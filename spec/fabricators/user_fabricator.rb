Fabricator(:user) do
  email { sequence(:email) { |i| "alex#{i}@alexmanelis.com" } }
  username { (0...8).map{65.+(rand(26)).chr}.join.downcase }
  password { 'password' }
  password_confirmation { 'password' }
  authentication_token { sequence(:authentication_token) { |i| "47gh140gh014#{i}vhg7#{i + 1}"} }
  identifier { SecureRandom.hex(25)[0...20] }
  created_at { DateTime.now }
  updated_at { DateTime.now }
  active { true } 
  
  projects(count: 2) do |project, i|
    Fabricate(:project, name: "#{i} proj")
  end
end

Fabricator(:admin, :from => :user) do
  admin { true }
end
