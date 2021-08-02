module WelcomeEmailComponent
  class Settings < ::Settings
    def self.instance
      @instance ||= build
    end

    def self.data_source
      Defaults.data_source
    end

    module Defaults
      def self.data_source
        ENV["WELCOME_EMAIL_COMPONENT_SETTINGS_PATH"] || "settings/welcome_email_component.json"
      end
    end
  end
end
