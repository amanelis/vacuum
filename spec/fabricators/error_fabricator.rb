Fabricator(:error) do
  level { 'warn' }
  message { 'uncaught syntax error' }
  resolved { false }
  count { 3 }
  identifier { SecureRandom.hex(25)[0...20] }
  created_at { DateTime.now }
  updated_at { DateTime.now }
  
  project do |project, i|
    Fabricate(:project, name: "#{i} proj")
  end
  
  # occurrences(count: 2) do |project, i|
  #   Fabricate(:occurrence)
  # end
end