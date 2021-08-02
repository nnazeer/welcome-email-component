require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Expected Version" do
      handler = Handlers::Events.new

      initiated = Controls::Events::Initiated.example

      welcome_email = Controls::WelcomeEmail::New.example

      version = Controls::Version.example
      next_version = version + 1

      handler.store.add(initiated.registration_id, welcome_email, version)

      handler.(initiated)

      writer = handler.write

      completed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Completed)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(completed) do |_, expected_version|
          expected_version == next_version
        end

        assert(written_to_stream)
      end
    end
  end
end
