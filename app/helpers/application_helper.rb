module ApplicationHelper
  # beautify_errors
  # @param: Hash
  # @return: String
  # purpose is to parse errors and print them in a readable nice format
  def beautify_errors(hash)
    hash.collect { |k,v| "#{k.upcase} #{v.first}" }.join(',').gsub(',', ', ')
  end
end
