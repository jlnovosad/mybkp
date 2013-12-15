class InvitationsMailer < ActionMailer::Base

  default :from => "MyBarkeepers <hello@mybarkeepers.com>"


  def new_message(message)
    @message = message
    mail(:to => "#{message.email}" :subject => "#{message.subject}")
  end

end