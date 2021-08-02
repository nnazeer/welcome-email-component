require_relative '../automated_init'

context "Projection" do
  context "Completed" do
    welcome_email = Controls::WelcomeEmail::New.example

    assert(welcome_email.completed_time.nil?)

    completed = Controls::Events::Completed.example

    registration_id = completed.registration_id or fail
    completed_time_iso8601 = completed.time or fail

    Projection.(welcome_email, completed)

    test "ID is set" do
      assert(welcome_email.id == completed.registration_id)
    end

    test "Completed time is converted and copied" do
      completed_time = Time.parse(completed_time_iso8601)

      assert(welcome_email.completed_time == completed_time)
    end
  end
end
