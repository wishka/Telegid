class ApplicationMailer < ActionMailer::Base
  layout 'mailer'

  default from: "myemail@gmail.com"

  def notify_customer(customer)
    puts "Going to send email!! to"
    puts customer
    mail(to: customer, subject: "Welcome!")
  end
end
