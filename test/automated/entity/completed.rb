require_relative "../automated_init"

context "Welcome Email" do
  context "Has Completed Time" do
    welcome_email = Controls::WelcomeEmail::Completed.example

    test "Is completed" do
      assert(welcome_email.completed?)
    end
  end

  context "Does not Have Completed Time" do
    welcome_email = Controls::WelcomeEmail.example

    test "is not completed" do
      refute(welcome_email.completed?)
    end
  end
end
