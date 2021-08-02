module WelcomeEmailComponent
  module Consumers
    module Registration
      class Events
        include Consumer::Postgres

        identifier 'welcomeEmail'

        handler Handlers::Registration::Events
      end
    end
  end
end
