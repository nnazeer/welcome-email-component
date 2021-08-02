require_relative '../automated_init'

context "Projection" do
  context "Started" do
    welcome_email = Controls::WelcomeEmail::New.example

    assert(welcome_email.started_time.nil?)

    started = Controls::Events::Started.example

    registration_id = started.registration_id or fail
    started_time_iso8601 = started.time or fail

    Projection.(welcome_email, started)

    test "ID is set" do
      assert(welcome_email.id == started.registration_id)
    end

    test "Started time is converted and copied" do
      started_time = Time.parse(started_time_iso8601)

      assert(welcome_email.started_time == started_time)
    end
  end
end
