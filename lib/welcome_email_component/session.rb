module WelcomeEmailComponent
  class Session < ::MessageStore::Postgres::Session
    settings.each do |setting_name|
      setting setting_name
    end

    def self.build(settings: nil)
      welcome_email_component_settings = Settings.instance
      message_store_settings = welcome_email_component_settings.data.dig("welcome_email_component", "message_store")

      settings = ::MessageStore::Postgres::Settings.build(message_store_settings)

      super(settings: settings)
    end
  end
end
