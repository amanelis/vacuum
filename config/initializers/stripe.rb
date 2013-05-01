if Rails.env.development? || Rails.env.production?
  STRIPE_SECRET_KEY       = 'roo18oi6q0tKADHttgsZ4FNQXNyDKv7S'
  STRIPE_PUBLISHABLE_KEY  = 'pk_jSXKsaEuajlnOpttqY47lOS5BrZgS'
elsif Rails.env.production?
  STRIPE_SECRET_KEY       = 'sUo8Lqpcm6rljcmbi8C4tWaGNCeEbRlL'
  STRIPE_PUBLISHABLE_KEY  = 'pk_PwZfGranq5XjyRAs56CvBD9QpTxIz'
end