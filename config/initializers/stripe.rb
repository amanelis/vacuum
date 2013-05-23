if Rails.env.development? || Rails.env.test?
  STRIPE_CLIENT_ID        = 'ca_17isuMNwZvYbVGMJ7RYUoVQ9gNunZvZd'
  STRIPE_SECRET_KEY       = 'roo18oi6q0tKADHttgsZ4FNQXNyDKv7S'
  STRIPE_PUBLISHABLE_KEY  = 'pk_jSXKsaEuajlnOpttqY47lOS5BrZgS'
elsif Rails.env.production?
  STRIPE_CLIENT_ID        = 'ca_17isxcpE2xaxBvmE8edK0CaVyuR1zOaN'
  STRIPE_SECRET_KEY       = 'sUo8Lqpcm6rljcmbi8C4tWaGNCeEbRlL'
  STRIPE_PUBLISHABLE_KEY  = 'pk_PwZfGranq5XjyRAs56CvBD9QpTxIz'
end

STRIPE_API_URL              = 'api.stripe.com'
STRIPE_BASE_URL             = 'connect.stripe.com'
STRIPE_OATUH_TOKEN_PATH     = '/oauth/token'
STRIPE_OAUTH_AUTHORIZE_URL  = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=#{STRIPE_CLIENT_ID}&scope=read_write"

Stripe.api_key = STRIPE_SECRET_KEY