module WelcomeEmailComponent
  module Controls
    module Registration
      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        11
      end

      def self.email_address
        "jane@example.com"
      end
    end
  end
end
