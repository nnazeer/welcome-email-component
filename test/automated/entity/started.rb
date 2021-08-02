require_relative "../automated_init"

context "Welcome Email" do
  context "Has Started Time" do
    welcome_email = Controls::WelcomeEmail::Started.example

    test "Is started" do
      assert(welcome_email.started?)
    end
  end

  context "Does not Have Started Time" do
    welcome_email = Controls::WelcomeEmail.example

    test "is not started" do
      refute(welcome_email.started?)
    end
  end
end
