class BotController < ApplicationController
 def webhook
   if params[‘hub.verify_token’] == ENV["VERIFY_TOKEN"]
     render text: params[‘hub.challenge’] and return
   else
     render text: ‘error’ and return
   end
  end
end