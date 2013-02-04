# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Vacuum::Application.initialize!

# Email with sendgrid
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app9868490@heroku.com',
  :password       => 'j5ubavuh',
  :domain         => 'vacuum.io'
}
ActionMailer::Base.delivery_method ||= :smtp
