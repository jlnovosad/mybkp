class InvitationsMailer < ActionMailer::Base

  default :from => "HeyBarkeep <heybarkeep@lifestylesupply.co>"


  def new_message(message)
    @message = message
    mail(:to => "#{message.email}", :subject => "#{message.subject}", :content_type => 'text/html')
  end

end