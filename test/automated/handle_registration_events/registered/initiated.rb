require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registered" do
    context "Initiated" do
      handler = Handlers::Registration::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      registered = Registration::Client::Controls::Events::Registered.example

      registration_id = registered.registration_id or fail
      user_id = registered.user_id or fail
      email_address = registered.email_address or fail

      handler.(registered)

      writer = handler.write

      initiated = writer.one_message do |event|
        event.instance_of?(Messages::Events::Initiated)
      end

      test "Initiated Event is Written" do
        refute(initiated.nil?)
      end

      test "Written to the welcome email stream" do
        written_to_stream = writer.written?(initiated) do |stream_name|
          stream_name == "welcomeEmail-#{registration_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "registration_id" do
          assert(initiated.registration_id == registration_id)
        end

        test "user_id" do
          assert(initiated.user_id == user_id)
        end

        test "email_address" do
          assert(initiated.email_address == email_address)
        end

        test "time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(initiated.time == processed_time_iso8601)
        end
      end
    end
  end
end
