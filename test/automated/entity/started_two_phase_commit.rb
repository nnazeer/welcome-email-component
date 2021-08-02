require_relative '../automated_init'

context "Welcome Email" do
  context "Has Started Time" do
    welcome_email = Controls::WelcomeEmail::Started.example

    test "Is started_two_phase_commit" do
      assert(welcome_email.started_two_phase_commit?)
    end

    context "Has Completed Time" do
      welcome_email = Controls::WelcomeEmail::Completed.example

      test "Is started_two_phase_commit" do
        assert(welcome_email.started_two_phase_commit?)
      end
    end

    context "Does not Have Started Time or Completed Time" do
      welcome_email = Controls::WelcomeEmail::New.example

      test "Is not started_two_phase_commit" do
        refute(welcome_email.started_two_phase_commit?)
      end
    end
  end
end
