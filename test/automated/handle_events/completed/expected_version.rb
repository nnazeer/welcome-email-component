require_relative '../../automated_init'

context "Handle Events" do
  context "Completed" do
    context "Expected Version" do
      handler = Handlers::Events.new

      completed = Controls::Events::Completed.example

      welcome_email = Controls::WelcomeEmail::Completed.example

      version = Controls::Version.example

      handler.store.add(welcome_email.id, welcome_email, version)

      handler.(completed)

      writer = handler.write

      sent = writer.one_message do |event|
        event.instance_of?(Messages::Events::Sent)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(sent) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
