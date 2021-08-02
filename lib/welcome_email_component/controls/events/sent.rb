module WelcomeEmailComponent
  module Controls
    module Events
      module Sent
        def self.example
          sent = WelcomeEmailComponent::Messages::Events::Sent.build

          sent.registration_id = Registration.id
          sent.user_id = User.id
          sent.email_address = Registration.email_address
          sent.time = Controls::Time::Effective.example
          sent.processed_time = Controls::Time::Processed.example

          sent
        end
      end
    end
  end
end
