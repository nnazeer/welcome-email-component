require_relative "../automated_init"

context "Welcome Email" do
  context "Has Initiated Time" do
    welcome_email = Controls::WelcomeEmail::Initiated.example

    test "Is initiated" do
      assert(welcome_email.initiated?)
    end
  end

  context "Does not Have Initiated Time" do
    welcome_email = Controls::WelcomeEmail::New.example

    test "is not initiated" do
      refute(welcome_email.initiated?)
    end
  end
end
