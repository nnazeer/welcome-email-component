module WelcomeEmailComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :welcome_email

    apply Initiated do |initiated|
      SetAttributes.(welcome_email, initiated, copy: [
        { :registration_id => :id },
        :user_id,
        :email_address
      ])
      welcome_email.initiated_time = Clock.parse(initiated.time)
    end

    apply Started do |started|
      welcome_email.id = started.registration_id
      welcome_email.started_time = Clock.parse(started.time)
    end

    apply Completed do |completed|
      welcome_email.id = completed.registration_id
      welcome_email.completed_time = Clock.parse(completed.time)
    end

    apply Sent do |sent|
      welcome_email.id = sent.registration_id
      welcome_email.sent_time = Clock.parse(sent.time)
    end
  end
end
