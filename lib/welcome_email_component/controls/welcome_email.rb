module WelcomeEmailComponent
  module Controls
    module WelcomeEmail
      def self.example
        welcome_email = WelcomeEmailComponent::WelcomeEmail.build

        welcome_email.id = Registration.id
        welcome_email.initiated_time = Time::Effective::Raw.example

        welcome_email
      end

      module New
        def self.example
          WelcomeEmailComponent::WelcomeEmail.build
        end
      end

      module Initiated
        def self.example
          WelcomeEmail.example
        end
      end

      module Started
        def self.example
          welcome_email = WelcomeEmail.example
          welcome_email.started_time = Time::Effective::Raw.example
          welcome_email
        end
      end

      module Completed
        def self.example
          welcome_email = WelcomeEmail.example
          welcome_email.completed_time = Time::Effective::Raw.example
          welcome_email
        end
      end

      module Sent
        def self.example
          welcome_email = WelcomeEmail.example
          welcome_email.sent_time = Time::Effective::Raw.example
          welcome_email
        end
      end
    end
  end
end
