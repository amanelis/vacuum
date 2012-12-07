module DefaultAttributeSetters
  def set_identifier
    self.identifier = SecureRandom.hex(25)[0...20] if self.try(:identifier).nil?
  end
  
  def set_api_key
    self.api_key = SecureRandom.hex(25)[0...40] if self.api_key.nil?
  end
end