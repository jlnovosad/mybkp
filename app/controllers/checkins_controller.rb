class CheckinsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # create
  #########################################
  def create
    @user = current_user
    @checkin = @user.checkins.build(params[:checkin])

    if (@checkin.venue_id.present? and @checkin.working == 'YES') 
      @venue = Venue.find_by_id(@checkin.venue_id)

      # find each device
      @devices = @user.devices
      @devices.each do |d|

        # notify followers
        device_token = '67004294d1bc637b8ba645d34da8b3be02f2d9af3d32531110b3d601fd98cd04'
        device_token = d.token
        notificationmessage = @user.name + ' is working now at ' + @venue.name + '!'
        APNS.send_notification(device_token, notificationmessage )
      }
    end

    
  
    if @user.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :checkin=>@checkin.as_json()
        } }
      end
    end
  end

  #########################################
  # destroy
  #########################################
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @checkin.as_json() } 
    end
  end

  private

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @checkin = current_user.checkins.find_by_id(params[:id])
    redirect_to root_url if @checkin.nil?
  end
  
end