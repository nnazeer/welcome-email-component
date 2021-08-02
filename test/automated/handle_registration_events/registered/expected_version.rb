require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registered" do
    context "Expected Version" do
      handler = Handlers::Registration::Events.new

      registered = Registration::Client::Controls::Events::Registered.example

      welcome_email = Controls::WelcomeEmail::New.example

      version = Controls::Version.example

      handler.store.add(registered.registration_id, welcome_email, version)

      handler.(registered)

      writer = handler.write

      initiated = writer.one_message do |event|
        event.instance_of?(Messages::Events::Initiated)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(initiated) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
