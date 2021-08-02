module WelcomeEmailComponent
  module Controls
    module Events
      module Completed
        def self.example
          completed = WelcomeEmailComponent::Messages::Events::Completed.build

          completed.registration_id = Registration.id
          completed.user_id = User.id
          completed.email_address = Registration.email_address
          completed.time = Controls::Time::Effective.example

          completed
        end
      end
    end
  end
end
