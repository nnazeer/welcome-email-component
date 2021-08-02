require_relative "../automated_init"

context "Welcome Email" do
  context "Has Sent Time" do
    welcome_email = Controls::WelcomeEmail::Sent.example

    test "Is sent" do
      assert(welcome_email.sent?)
    end
  end

  context "Does not Have Sent Time" do
    welcome_email = Controls::WelcomeEmail.example

    test "is not sent" do
      refute(welcome_email.sent?)
    end
  end
end
