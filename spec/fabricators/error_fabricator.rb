Fabricator(:error) do
  level { 'warn' }
  message { 'uncaught syntax error' }
  resolved { false }
  count { 3 }
  identifier { SecureRandom.hex(25)[0...20] }
  
  after_create  { |error| Fabricate(:occurrence, :error => self) } 
end