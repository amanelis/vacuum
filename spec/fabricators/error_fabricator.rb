Fabricator(:error) do
  level { 'warn' }
  message { 'uncaught syntax error' }
  resolved { false }
  count { 3 }
  identifier { SecureRandom.hex(25)[0...20] }
  created_at { DateTime.now }
  updated_at { DateTime.now }
  
  after_build { |error| error.occurrences << Fabricate(:occurrence) } 
end