class LocationsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @location = Location.paginate(page: params[:page], :per_page => 50).order('lower(city) ASC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :location=>@location.as_json(:only => [:id, :city, :state]) 
      } }
    end
  end

  def create
    @location = Location.find_or_create_by_city_and_state(params[:location][:city], params[:location][:state])
    @user = current_user
    @user.update_attributes(location_id: @location.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :location=>@location.as_json(:only => [:id, :city, :state]) 
      } }
    end
  end

  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :location=>@location.as_json(:only => [:id, :city, :state]) 
      } }
    end
  end

end