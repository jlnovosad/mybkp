class ShiftsController < ApplicationController
  before_filter :authenticate_user!
  
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
end