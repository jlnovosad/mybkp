class TokensController  < ApplicationController

  #########################################
  # skips verify_authenticity_token because you are doing email and password instead
  #########################################
  skip_before_filter :verify_authenticity_token
  respond_to :json

  #########################################
  # user submits email and password to get a token for his phone
  #########################################
  def create

    # get args
    email = params[:user][:email]
    phone = params[:user][:phone]
    password = params[:user][:password]

    # some error checking
    if request.format != :json
      render :status=>406, :json=>{:message=>"Oops! The request must be json."}
      return
    end
    if (email.nil? and phone.nil?) or password.nil?
       render :status=>400,
              :json=>{:message=>"Oops! Invalid email/phone or password."}
       return
    end

    if email.nil?
      # find phone
      @user=User.find_by_phone(phone.downcase)
      if @user.nil?
        logger.info("User #{phone} failed signin, user cannot be found.")
        render :status=>401, :json=>{:message=>"Oops! Invalid phone or password."}
        return
      end
    else
      # find email
      @user=User.find_by_email(email.downcase)
      if @user.nil?
        logger.info("User #{email} failed signin, user cannot be found.")
        render :status=>401, :json=>{:message=>"Oops! Invalid email or password."}
        return
      end
    end

    # http://rdoc.info/github/plataformatec/devise/master/Devise/Models/TokenAuthenticatable
    @user.ensure_authentication_token!

    # is the password right?
    if not @user.valid_password?(password)
      logger.info("User #{email} failed signin, password \"#{password}\" is invalid")
      render :status=>401, :json=>{:message=>"Oops! Invalid email or password."}
    else

      #########################################
      # give them the token!
      #########################################
      render :status=>200, :json=>{:token=>@user.authentication_token, :id=>@user.id}
    end
  end

  #########################################
  # destroy token, not used
  #########################################
  def destroy
    @user=User.find_by_authentication_token(params[:id])
    if @user.nil?
      #logger.info(“Token not found.”)
      #render :status=>404, :json=>{:message=>”Invalid token.”}
    else
      @user.reset_authentication_token!
      render :status=>200, :json=>{:token=>params[:id]}
    end
  end
end