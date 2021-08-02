module WelcomeEmailComponent
  module Messages
    module Events
      class Completed
        include Messaging::Message

        attribute :registration_id, String
        attribute :user_id, String
        attribute :email_address, String
        attribute :time, String
      end
    end
  end
end
