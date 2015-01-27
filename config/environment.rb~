# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LeaveSystem::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => 'smtp.gmail.com',
:port => 587,
:authentication => :plain,
:user_name => 'rapidthinksoftware@gmail.com',
:password => 'passwordabc123',
:openssl_verify_mode => 'none'
}

