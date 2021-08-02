module WelcomeEmailComponent
  class Store
    include EntityStore

    category :welcome_email
    entity WelcomeEmail
    projection Projection
    reader MessageStore::Postgres::Read
  end
end
