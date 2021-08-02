require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Ignored" do
      handler = Handlers::Events.new

      initiated = Controls::Events::Initiated.example

      welcome_email = Controls::WelcomeEmail::Started.example

      handler.store.add(welcome_email.id, welcome_email)

      handler.(initiated)

      writer = handler.write

      started = writer.one_message do |event|
        event.instance_of?(Messages::Events::Started)
      end

      test "Started Event is not Written" do
        assert(started.nil?)
      end
    end
  end
end
