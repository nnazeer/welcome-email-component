module WelcomeEmailComponent
  module Controls
    module Events
      module Initiated
        def self.example
          initiated = WelcomeEmailComponent::Messages::Events::Initiated.build

          initiated.registration_id = Registration.id
          initiated.user_id = User.id
          initiated.email_address = Registration.email_address
          initiated.time = Controls::Time::Effective.example

          initiated
        end
      end
    end
  end
end
