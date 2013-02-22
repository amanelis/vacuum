Fabricator(:occurrence) do
  file { "http://alexmanelis.com/javascripts/all.js" }
  line { "34"}
  href { "http://alexmanelis.com/about.html" }
  parameters { '' }
  language { 'en-us' }
  platform { 'MacIntel' }
  product { 'Mozilla' }
  protocol { 'http:' }
  app_name { 'Firefox' }
  cookie_enabled { true }
  user_agent { 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.30 (KHTML, like Gecko) Chrome/26.0.1400.0 Safari/537.30' }
  user_address { '75.149.44.118' }
  window_event { '[object ErrorEvent]' }
  stack_trace { '' }
  browser_time { '' }
  identifier { SecureRandom.hex(25)[0...20] }
end