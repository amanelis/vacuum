# Vacuum
Everything that enables Vacuum to capture and report errors lives here in this repo. The CDN that holds the JS people copy onto their site lives in Cloudfront. Getting vacuum setup locally is fairly simple. Just follow the steps below.

## Setup
Start with a clone and a bundle install to get going, be sure mongo is installed.

	$ bundle exec rake db:drop db:create db:migrate db:seed
	
For production data, you will need to first have access to the heroku application.

	$ heroku mongo:pull --app vacuumup
	
Run the application with either rails server or foreman. If you use foreman, it will start mongo for you.

	$ foreman start