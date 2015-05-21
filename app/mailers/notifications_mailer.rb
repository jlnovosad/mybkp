class NotificationsMailer < ActionMailer::Base

  default :from => "Good Times<goodtimes@lifestylesupply.co>"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end