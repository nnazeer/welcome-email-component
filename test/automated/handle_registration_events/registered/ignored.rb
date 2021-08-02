require_relative '../../automated_init'

context "Handle Registration Events" do
  context "Registered" do
    context "Ignored" do
      handler = Handlers::Registration::Events.new

      registered = Registration::Client::Controls::Events::Registered.example

      welcome_email = Controls::WelcomeEmail::Initiated.example

      handler.store.add(welcome_email.id, welcome_email)

      handler.(registered)

      writer = handler.write

      initiated = writer.one_message do |event|
        event.instance_of?(Messages::Events::Initiated)
      end

      test "Initiated Event is not Written" do
        assert(initiated.nil?)
      end
    end
  end
end
