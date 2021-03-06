class ShiftsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy
  
  #########################################
  # creates new
  #########################################
  def create
    
    # created through user and the connection will already be there
    @shift = current_user.shifts.create(params[:shift])
      
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :shift=>@shift.as_json()
      } }
    end
  end

  #########################################
  # destroy
  #########################################
  def destroy
    @shift.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @shift.as_json() } 
    end
  end

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @shift = current_user.shifts.find_by_id(params[:id])
    redirect_to root_url if @shift.nil?
  end
end