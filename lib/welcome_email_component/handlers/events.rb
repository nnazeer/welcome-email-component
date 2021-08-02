module WelcomeEmailComponent
  module Handlers
    class Events
      include Log::Dependency
      include Messaging::Handle
      include Messaging::StreamName
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store
      dependency :smtp_email, SMTP::Email

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)

        welcome_email_component_settings = Settings.instance
        smtp_settings_data = welcome_email_component_settings.data.dig("welcome_email_component", "smtp")
        settings = ::Settings.build(smtp_settings_data)

        SMTP::Email.configure(self, settings: settings)
      end

      category :welcome_email

      handle Initiated do |initiated|
        registration_id = initiated.registration_id

        welcome_email, version = store.fetch(registration_id, include: :version)

        if welcome_email.started_two_phase_commit?
          logger.info(tag: :ignored) { "Event ignored (Event: #{initiated.message_type}, Registration ID: #{registration_id}, User ID: #{initiated.user_id})" }
          return
        end

        email_address = initiated.email_address
        from = "sender@example.com"
        subject = "Welcome!"
        body = "Welcome to the application!"

        stream_name = stream_name(registration_id)

        started = Started.follow(initiated, exclude: :time)
        started.time = clock.iso8601

        write.(started, stream_name, expected_version: version)

        smtp_email.(email_address, from, subject, body)

        if version == :no_stream
          next_version = 1
        else
          next_version = version + 1
        end

        completed = Completed.follow(started, exclude: :time)
        completed.time = clock.iso8601

        write.(completed, stream_name, expected_version: next_version)
      end

      handle Completed do |completed|
        registration_id = completed.registration_id

        welcome_email, version = store.fetch(registration_id, include: :version)

        if welcome_email.sent?
          logger.info(tag: :ignored) { "Event ignored (Event: #{completed.message_type}, Registration ID: #{registration_id}, User ID: #{completed.user_id})" }
          return
        end

        time = clock.iso8601

        stream_name = stream_name(registration_id)

        sent = Sent.follow(completed)
        sent.processed_time = time

        write.(sent, stream_name, expected_version: version)
      end
    end
  end
end
