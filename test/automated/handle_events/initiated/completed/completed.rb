require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Completed" do
      handler = Handlers::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      initiated = Controls::Events::Initiated.example

      registration_id = initiated.registration_id or fail
      user_id = initiated.user_id or fail
      email_address = initiated.email_address or fail

      handler.(initiated)

      writer = handler.write

      completed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Completed)
      end

      test "Completed Event is Written" do
        refute(completed.nil?)
      end

      test "Written to the welcome email stream" do
        written_to_stream = writer.written?(completed) do |stream_name|
          stream_name == "welcomeEmail-#{registration_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "registration_id" do
          assert(completed.registration_id == registration_id)
        end

        test "user_id" do
          assert(completed.user_id == user_id)
        end

        test "email_address" do
          assert(completed.email_address == email_address)
        end

        test "time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(completed.time == processed_time_iso8601)
        end
      end
    end
  end
end
