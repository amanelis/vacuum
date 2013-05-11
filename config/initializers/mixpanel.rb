if Rails.env.development? || Rails.env.test?
  MIXPANEL_TOKEN = 'c6ee23bb6a20b33c47ebd629d74ec395'
elsif Rails.env.production?
  MIXPANEL_TOKEN = '96579f2442588d31a0d8aff7df73f36a'
else
  MIXPANEL_TOKEN = ''
end