class VenuesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # lists all the venues that we have saved, not actually used
  #########################################
  def index
    @venues = Venue.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venues=>@venues.as_json(:only => [:id, :fs_venue_id], :include => { :users => { :only => [:id, :name, :tender], :methods => [:photo_url] } }) 
        } }
    end
  end

  #########################################
  # creates a new venue, note that it goes through a user to do this, this is also just to get venue data (but a new one wont be saved)
  #########################################
  def feed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.feed.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:content, :created_at], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :venue => { :only => [:id, :fs_venue_id] } 
          }
        )
      } }
    end
  end
  
  def create
    @venue = current_user.venues.build(params[:venue])
    if @venue.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id], :include => { :users => { :only => [:id, :name, :tender], :methods => [:photo_url] } }) 
          } }
      end
    else
      # render :json => { :errors => @venue.errors 
      # if the venue was already in the db, return that entry so the app has the info anyway
      @venue = Venue.find_by_fs_venue_id(params[:venue][:fs_venue_id])
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id], :include => { :users => { :only => [:id, :name, :tender], :methods => [:photo_url] } }) 
          } }
      end
    end
  end

  #########################################
  # accesses the join table between users and venues
  #########################################
  def favorite
    @user = current_user
    @venue = Venue.find(params[:id])
    @user.venues << @venue 
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id]) 
        } }
    end
  end

  #########################################
  # accesses the join table between users and venues
  #########################################
  def unfavorite
    @user = current_user
    @venue = Venue.find(params[:id])
    @user.venues.delete(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id]) 
        } }
    end
  end

  private

    #########################################
    # only you can perform actions on your stuff
    #########################################
    def correct_user
      @venue = current_user.venues.find_by_id(params[:id])
      redirect_to root_url if @venue.nil?
    end
end