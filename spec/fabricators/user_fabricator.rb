Fabricator(:user) do
  email { sequence(:email) { |i| "alex#{i}@alexmanelis.com" } }
  username { (0...8).map{65.+(rand(26)).chr}.join.downcase }
  password { 'password' }
  password_confirmation { 'password' }
  authentication_token { (0...8).map{65.+(rand(26)).chr}.join.downcase }
  identifier { SecureRandom.hex(25)[0...20] }
  active { true } 
end

Fabricator(:admin, :from => :user) do
  admin { true }
end