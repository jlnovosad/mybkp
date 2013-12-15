class RegistrationsController < Devise::RegistrationsController
  
  before_filter :authenticate_user!

  # need this to add custom 'name' field to devise in Rails 4
  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end
  
  # overriding this one so you don't need to enter password, you are already logged in
  def update
    
    # required for settings form to submit when password is left blank
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    Rails.logger.debug(params[:user]) 
    
    if @user.update_attributes(params[:user])
      set_flash_message :notice, :updated
      
      # Sign in the user bypassing validation in case his password changed
      respond_to do |format|
        format.html { 
          sign_in @user, :bypass => true
          redirect_to after_update_path_for(@user)
        }
        format.json  { render :json=> { 
          :user=>@user.as_json(:only => [:id, :name, :email, :tender], :methods => [:photo_url]) 
        } }
      end
    else
      render "edit"
    end
  end

  # for inviting

  around_filter :destroy_if_previously_invited, :only => :create 

  private

  def destroy_if_previously_invited
    invitation_info = {}
    tempfollowers = {}
    specialfollowers = {}

    user_hash = params[:user]
    
    Rails.logger.debug("AROUND CREATE")
    Rails.logger.debug(params[:user]) 
    
    ########
    @jluser = User.find(1)
    if @jluser.followers.any? 


      jltempfollowers = @jluser.followers
    end
    @puser = User.find(2)
    if @puser.followers.any? 


      ptempfollowers = @puser.followers
    end
    @tuser = User.find(3)
    if @tuser.followers.any? 


      ttempfollowers = @tuser.followers
    end
    @tuser4 = User.find(4)
    if @tuser4.followers.any? 


      ttempfollowers4 = @tuser4.followers
    end
    @tuser5 = User.find(5)
    if @tuser5.followers.any? 


      ttempfollowers5 = @tuser5.followers
    end
    ########

    if user_hash && user_hash[:email]
      @user = User.find_by_email_and_encrypted_password(user_hash[:email], '')
      
      if @user
        invitation_info[:invitation_sent_at] = @user[:invitation_sent_at]
        invitation_info[:invited_by_id] = @user[:invited_by_id]
        invitation_info[:invited_by_type] = @user[:invited_by_type]

        Rails.logger.debug("AROUND CREATE DESTROYING")

        # need to save friends here also
        if @user.followers.any? 

          Rails.logger.debug("AROUND CREATE followers")

          tempfollowers = @user.followers
          specialfollowers = @jluser.followers
        end

        @user.destroy
      end
    end

    

    Rails.logger.debug("AROUND CREATE 2")

    # execute the action (create)
    yield
    # Note that the after_filter is executed at THIS position !

    Rails.logger.debug("AROUND CREATE 3")

    # Restore info about the last invitation (for later reference)
    # Reset the invitation_info only, if invited_by_id is still nil at this stage:
    @user = User.find_by_email_and_invited_by_id(user_hash[:email], nil)

    Rails.logger.debug("AROUND CREATE 4")
    Rails.logger.debug(@user) 

    if @user
      @user[:invitation_sent_at] = invitation_info[:invitation_sent_at]
      @user[:invited_by_id] = invitation_info[:invited_by_id]
      @user[:invited_by_type] = invitation_info[:invited_by_type]

      Rails.logger.debug("AROUND CREATE 5")
      Rails.logger.debug(@user) 

      # add friends
      if tempfollowers.any?
        tempfollowers.each do |follower|
          Rails.logger.debug("AROUND CREATE tempfollowers")
          follower.follow!(@user, "FOLLOWING")
        end
        @puser.follow!(@user, "FOLLOWING")
      else 
        @tuser.follow!(@user, "FOLLOWING")
      end

      if specialfollowers.any?
        specialfollowers.each do |follower|
          #follower.follow!(@user, "FOLLOWING")
        end
        @tuser4.follow!(@user, "FOLLOWING")
      else 
        @tuser5.follow!(@user, "FOLLOWING")
      end

      Rails.logger.debug("AROUND CREATE 6")
      Rails.logger.debug(@user) 

      @user.save!
    end

    ########
    if jltempfollowers.any?
      jltempfollowers.each do |follower|
        Rails.logger.debug("jl CREATE tempfollowers")
        #follower.follow!(@user, "FOLLOWING")
      end
    end
    ########
  end

end




