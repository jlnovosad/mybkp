class NotificationsMailer < ActionMailer::Base

  default :from => "MyBarkeepers <noreply@mybarkeepers.com>"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end