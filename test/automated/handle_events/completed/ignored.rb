require_relative '../../automated_init'

context "Handle Events" do
  context "Completed" do
    context "Ignored" do
      handler = Handlers::Events.new

      completed = Controls::Events::Completed.example

      welcome_email = Controls::WelcomeEmail::Sent.example

      handler.store.add(welcome_email.id, welcome_email)

      handler.(completed)

      writer = handler.write

      sent = writer.one_message do |event|
        event.instance_of?(Messages::Events::Sent)
      end

      test "Sent Event is not Written" do
        assert(sent.nil?)
      end
    end
  end
end
