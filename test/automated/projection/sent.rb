require_relative '../automated_init'

context "Projection" do
  context "Sent" do
    welcome_email = Controls::WelcomeEmail::New.example

    assert(welcome_email.sent_time.nil?)

    sent = Controls::Events::Sent.example

    registration_id = sent.registration_id or fail
    sent_time_iso8601 = sent.time or fail

    Projection.(welcome_email, sent)

    test "ID is set" do
      assert(welcome_email.id == sent.registration_id)
    end

    test "Sent time is converted and copied" do
      sent_time = Time.parse(sent_time_iso8601)

      assert(welcome_email.sent_time == sent_time)
    end
  end
end
