class InvitationsMailer < ActionMailer::Base

  default :from => "MyBarkeepers <hello@mybarkeepers.com>"


  def new_message(message)
    @message = message
		mail(:subject => "#{message.subject}")
  end

end