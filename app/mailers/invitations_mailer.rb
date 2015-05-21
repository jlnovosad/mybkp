class InvitationsMailer < ActionMailer::Base

  default :from => "Good Times<goodtimes@lifestylesupply.co>"


  def new_message(message)
    @message = message
    mail(:to => "#{message.email}", :subject => "#{message.subject}", :content_type => 'text/html')
  end

end