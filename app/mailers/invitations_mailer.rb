class InvitationsMailer < ActionMailer::Base

  default :from => "MyBarkeepers <noreply@mybarkeepers.com>"

  def new_message(message)
    @message = message

    @subject = "Let's Have a Drink..."
    @body = "	<p>Hello #{message.email}!</p>

							<p>#{message.name} has invited you to try out MyBarkeepers, a new app for iPhone that lets you keep in touch with your favorite bartenders.</p>
							<p>Follow your favorite people and places to find tonight's best drink destination.</p>
							<p>Learn more and download the app for iPhone at <a href='https://www.mybarkeepers.com'>mybarkeepers.com</a>.</p>"

		mail(:subject => "#{message.subject}", :to => "#{message.email}", :body => @body, :content_type => "text/html")
  end

end