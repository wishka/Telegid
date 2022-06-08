ActionMailer::Base.add_delivery_method :cloudmailin, Mail::SMTP,
  address: ENV['CLOUDMAILIN_FORWARD_ADDRESS'],
  port: 587,
  domain: '<telegagid>.herokuapp.com',
  user_name: ENV['CLOUDMAILIN_USERNAME'],
  password: ENV['CLOUDMAILIN_SECRET'],
  authentication: 'plain',
  enable_starttls_auto: true
