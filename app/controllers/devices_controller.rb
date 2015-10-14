class DevicesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # creates a new or finds the existing
  #########################################
  def create
    @user = current_user
    @device = Device.find_by_token_and_user_id(params[:device][:token],@user.id)
    if @device

      # if the device was already in the db, return that entry so the app has the info anyway (refresh name first)
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :device=>@device.as_json() 
        } }
      end
    else
      
      # create
      @device = Device.create(params[:device])

      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :device=>@device.as_json() 
        } }
      end
    end
  end
end