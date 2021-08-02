require_relative '../../automated_init'

context "Handle Events" do
  context "Completed" do
    context "Sent" do
      handler = Handlers::Events.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      completed = Controls::Events::Completed.example

      registration_id = completed.registration_id or fail
      user_id = completed.user_id or fail
      email_address = completed.email_address or fail
      effective_time = completed.time or fail

      handler.(completed)

      writer = handler.write

      sent = writer.one_message do |event|
        event.instance_of?(Messages::Events::Sent)
      end

      test "Sent Event is Written" do
        refute(sent.nil?)
      end

      test "Written to the welcome email stream" do
        written_to_stream = writer.written?(sent) do |stream_name|
          stream_name == "welcomeEmail-#{registration_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "registration_id" do
          assert(sent.registration_id == registration_id)
        end

        test "user_id" do
          assert(sent.user_id == user_id)
        end

        test "email_address" do
          assert(sent.email_address == email_address)
        end

        test "time" do
          assert(sent.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(sent.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
