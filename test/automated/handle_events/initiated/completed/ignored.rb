require_relative '../../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "Ignored" do
      handler = Handlers::Events.new

      initiated = Controls::Events::Initiated.example

      welcome_email = Controls::WelcomeEmail::Completed.example

      handler.store.add(welcome_email.id, welcome_email)

      handler.(initiated)

      writer = handler.write

      completed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Completed)
      end

      test "Completed Event is not Written" do
        assert(completed.nil?)
      end
    end
  end
end
