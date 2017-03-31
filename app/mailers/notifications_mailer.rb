class NotificationsMailer < ActionMailer::Base

  default :from => "YipTip<YipTip@popzenith.com>"
  default :to => "jlnovosad@gmail.com"

  def new_message(message)
    @message = message
    mail(:subject => "#{message.subject}")
  end

end