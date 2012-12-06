Fabricator(:user) do
  email { sequence(:email) { |i| "alex#{i}@alexmanelis.com" } }
  password { 'password' }
  password_confirmation { 'password' }
  authentication_token { sequence(:authentication_token) { |i| "47gh140gh014#{i}vhg7#{i + 1}"} }
end