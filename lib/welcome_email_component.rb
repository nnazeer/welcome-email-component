require 'eventide/postgres'

require 'registration/client'
require 'smtp/email'

require 'welcome_email_component/settings'
require 'welcome_email_component/session'

require 'welcome_email_component/load'

require 'welcome_email_component/welcome_email'
require 'welcome_email_component/projection'
require 'welcome_email_component/store'

require 'welcome_email_component/handlers/events'
require 'welcome_email_component/handlers/registration/events'
