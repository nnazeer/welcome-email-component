require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Started" do
      handler = Handlers::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      initiated = Controls::Events::Initiated.example

      registration_id = initiated.registration_id or fail
      user_id = initiated.user_id or fail
      email_address = initiated.email_address or fail

      handler.(initiated)

      writer = handler.write

      started = writer.one_message do |event|
        event.instance_of?(Messages::Events::Started)
      end

      test "Started Event is Written" do
        refute(started.nil?)
      end

      test "Written to the welcome email stream" do
        written_to_stream = writer.written?(started) do |stream_name|
          stream_name == "welcomeEmail-#{registration_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "registration_id" do
          assert(started.registration_id == registration_id)
        end

        test "user_id" do
          assert(started.user_id == user_id)
        end

        test "email_address" do
          assert(started.email_address == email_address)
        end

        test "time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(started.time == processed_time_iso8601)
        end
      end
    end
  end
end
