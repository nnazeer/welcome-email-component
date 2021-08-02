module WelcomeEmailComponent
  class Start
    def self.build
      instance = new
      instance
    end

    def call
      welcome_email_component_settings = Settings.instance
      message_store_settings = welcome_email_component_settings.data.dig("welcome_email_component", "message_store")

      settings = ::MessageStore::Postgres::Settings.build(message_store_settings)

      Consumers::Events.start("welcomeEmail", settings: settings)
      Consumers::Registration::Events.start("registration", settings: settings)
    end
  end
end
