module WelcomeEmailComponent
  module Controls
    module Events
      module Started
        def self.example
          started = WelcomeEmailComponent::Messages::Events::Started.build

          started.registration_id = Registration.id
          started.user_id = User.id
          started.email_address = Registration.email_address
          started.time = Controls::Time::Effective.example

          started
        end
      end
    end
  end
end
