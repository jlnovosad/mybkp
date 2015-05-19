class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications.all
  end
  
  def home
  end
  
  def twitter
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication

      # There maybe a user, who is already authenticated before.

      flash[:notice] = "Logged in Successfully"
      sign_in_and_redirect User.find(authentication.user_id)
    elsif current_user

      # There maybe a person, who is going to register to our website by authenticating the Twitter.

      token = omni['credentials'].token
      token_secret = omni['credentials'].secret

      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
      flash[:notice] = "Authentication successful."
      sign_in_and_redirect current_user
    else

      # There exists a user, who is not authenticated his/her twitter account yet.

      user = User.new 
      user.apply_omniauth(omni)

      if user.save
        flash[:notice] = "Logged in."
        sign_in_and_redirect User.find(user.id)             
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end 
  end
   
  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
   
   
  def facebook
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication

      # There maybe a user, who is already authenticated before.

      @user = User.find(authentication.user_id)

      flash[:notice] = "Logged in Successfully"
      respond_to do |format|
        format.html {
          sign_in_and_redirect User.find(authentication.user_id)
        }
        format.json  { render :json=> { 
          :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
            :include => { 
              :drinks => { :only => [:id, :name] },
              :workvenues => { :only => [:id, :fs_venue_id, :name] }
            }
          ) 
        } }
      end
    elsif current_user

      # There maybe a person, who is going to register to our website by authenticating the Facebook.

      token = omni['credentials'].token
      token_secret = ""

      current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

      @user = current_user 

      flash[:notice] = "Authentication successful."
      respond_to do |format|
        format.html {
          sign_in_and_redirect current_user
        }
        format.json  { render :json=> { 
          :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
            :include => { 
              :drinks => { :only => [:id, :name] },
              :workvenues => { :only => [:id, :fs_venue_id, :name] }
            }
          ) 
        } }
      end
    else

      # There exists a user, who is not authenticated his/her Facebook account yet.

      @user = User.new
      @user.email = omni['extra']['raw_info'].email 

      @user.apply_omniauth(omni)

      if @user.save
        flash[:notice] = "Logged in."
        respond_to do |format|
          format.html {
            sign_in_and_redirect User.find(user.id) 
          }
          format.json  { render :json=> { 
          :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
            :include => { 
              :drinks => { :only => [:id, :name] },
              :workvenues => { :only => [:id, :fs_venue_id, :name] }
            }
          ) 
        } }
        end       
      else
        session[:omniauth] = omni.except('extra')
        redirect_to new_user_registration_path
      end
    end
  end 
end