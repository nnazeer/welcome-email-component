require_relative '../../automated_init'

context "Handle Events" do
  context "Initiated" do
    context "SMTP Email" do
      handler = Handlers::Events.new

      initiated = Controls::Events::Initiated.example

      registration_id = initiated.registration_id or fail
      user_id = initiated.user_id or fail
      email_address = initiated.email_address or fail

      handler.(initiated)

      smtp_email = handler.smtp_email

      context "Recorded Attributes" do
        test "To" do
          sent = smtp_email.sent? do |to|
            to == email_address
          end

          assert(sent)
        end

        test "From" do
          sent = smtp_email.sent? do |to, from|
            from == "sender@example.com"
          end

          assert(sent)
        end

        test "Subject" do
          sent = smtp_email.sent? do |to, from, subject|
            subject == "Welcome!"
          end

          assert(sent)
        end
      end
    end
  end
end
