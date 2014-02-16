# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Demo::Application.initialize!

ActionMailer::Base.default_url_options = {:host => CONFIG[:host]}

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  address: "smtp.gmail.com",
  port: 587,
  domain: "example.com",
  authentication: "plain",
  user_name: "thanh.nguyen.10008@gmail.com", 
  password: "nguyencongthanh",
  enable_starttls_auto: true
}