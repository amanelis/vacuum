Fabricator(:project) do
  name        { Faker::Internet.user_name }
  url         { "http://#{Faker::Internet.domain_name}"}
  enabled     { true }
  api_key     { SecureRandom.hex(25)[0...35] }
  identifier  { SecureRandom.hex(25)[0...20] }
  
  Fabricate(:user)
end