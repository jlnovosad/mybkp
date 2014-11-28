class NotificationsMailer < ActionMailer::Base

  default :from => "HeyBarkeep!<heybarkeep@lifestylesupply.co"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end