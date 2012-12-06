module DefaultAttributeSetters
  def set_identifier
    self.identifier = SecureRandom.hex(25)[0...20] if self.try(:identifier).nil?
  end
  
  def set_created_at
    date_time = Proc.new { DateTime.now }.call
    self.created_at = date_time if self.created_at.nil?
    self.updated_at = date_time if self.updated_at.nil?
  end
  
  def set_updated_at
    date_time = Proc.new { DateTime.now }.call
    self.updated_at = date_time 
  end
  
  def set_api_key
    self.api_key = SecureRandom.hex(25)[0...40] if self.api_key.nil?
  end
end