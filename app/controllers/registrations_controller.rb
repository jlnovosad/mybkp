class RegistrationsController < Devise::RegistrationsController
  
  before_filter :authenticate_user!

  # need this to add custom 'name' field to devise in Rails 4
  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :phone, :email, :password, :password_confirmation, :remember_me, :tender, :privateprofile, :bio, :location_id, :photo)
    end
  end
  
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

  def destroy
    @user = current_user
    @user.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @user.as_json() } 
    end
  end
  
  def build_resource(*args)
      super
      if session[:omniauth]
        @user.apply_omniauth(session[:omniauth])
        @user.valid?
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
          :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
            :include => { 
              :workvenues => { :only => [:id, :fs_venue_id, :name] },
              :shifts => { },
              :devices => { :only => [:id] }
            }
          ) 
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
    tempfollowers = []

    user_hash = params[:user]
    if user_hash && user_hash[:email]
      @user = User.find_by_email_and_encrypted_password(user_hash[:email], '')
      
      if @user
        params[:user][:notify] = 'YES'
        user_hash[:notify] = 'YES'
        invitation_info[:invitation_sent_at] = @user[:invitation_sent_at]
        invitation_info[:invited_by_id] = @user[:invited_by_id]
        invitation_info[:invited_by_type] = @user[:invited_by_type]

        # need to save friends here also
        if @user.followers.any? 
          @user.followers.each do |follower|
            tempfollowers << follower
          end
        end

        @user.destroy
      end
    end

    # workaround for Android location error for now
    params[:user][:location_id] = 1

    # execute the action (create)
    yield
    # Note that the after_filter is executed at THIS position !

    # Restore info about the last invitation (for later reference)
    # Reset the invitation_info only, if invited_by_id is still nil at this stage:
    @user = User.find_by_email_and_invited_by_id(user_hash[:email], nil)

    if @user
      @user[:invitation_sent_at] = invitation_info[:invitation_sent_at]
      @user[:invited_by_id] = invitation_info[:invited_by_id]
      @user[:invited_by_type] = invitation_info[:invited_by_type]

      # add friends
      if tempfollowers.any?
        tempfollowers.each do |follower|
          follower.follow!(@user, "FOLLOWING")
        end
        @user.update_attributes!(:notify => "YES")
      end

      @user.save!
    end

  end

end




