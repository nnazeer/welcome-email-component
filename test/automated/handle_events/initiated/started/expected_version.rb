require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Expected Version" do
      handler = Handlers::Events.new

      initiated = Controls::Events::Initiated.example

      welcome_email = Controls::WelcomeEmail::New.example

      version = Controls::Version.example

      handler.store.add(initiated.registration_id, welcome_email, version)

      handler.(initiated)

      writer = handler.write

      started = writer.one_message do |event|
        event.instance_of?(Messages::Events::Started)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(started) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
