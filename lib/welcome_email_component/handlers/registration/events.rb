module WelcomeEmailComponent
  module Handlers
    module Registration
      class Events
        include Log::Dependency
        include Messaging::Handle
        include Messaging::StreamName
        include Messages::Events

        dependency :write, Messaging::Postgres::Write
        dependency :clock, Clock::UTC
        dependency :store, Store

        def configure
          Messaging::Postgres::Write.configure(self)
          Clock::UTC.configure(self)
          Store.configure(self)
        end

        category :welcome_email

        handle ::Registration::Client::Messages::Events::Registered do |registered|
          registration_id = registered.registration_id

          registration, version = store.fetch(registration_id, include: :version)

          if registration.initiated?
            logger.info(tag: :ignored) { "Event ignored (Event: #{registered.message_type}, Registration ID: #{registration_id}, User ID: #{registered.user_id})" }
            return
          end

          time = clock.iso8601

          stream_name = stream_name(registration_id)

          initiated = Initiated.follow(registered)
          initiated.time = time

          write.(initiated, stream_name, expected_version: version)
        end
      end
    end
  end
end
