# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vacuum::Application.initialize!

# Email with amazon
ActionMailer::Base.delivery_method ||= :smtp
ActionMailer::Base.smtp_settings = {
  :address        => 'email-smtp.us-east-1.amazonaws.com',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'AKIAJ5SBLAFSPLD4GW2Q',
  :password       => 'AmxRqmgxHTUYvYGv/TmHc8xMkBl5q5ex1GRqvYsxlaHS',
  :domain         => 'vacuum.io'
}