class VenuesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # lists all the venues that we have saved, not actually used
  #########################################
  def index
    @venues = Venue.paginate(page: params[:page], :per_page => 50)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id], 
          :include => { 
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] } 
          }
        ) 
      } }
    end
  end

  #########################################
  # venue tagged in posts
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
  
  #########################################
  # creates a new venue, note that it goes through a user to do this 
  # if it is already in the db, just get venue data
  #########################################
  def create
    @venue = Venue.find_by_fs_venue_id(params[:venue][:fs_venue_id])
    if @venue

      # if the venue was already in the db, return that entry so the app has the info anyway

      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id], 
            :include => { 
              :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :favorites => { :only => [:id, :user_id, :venue_id] },
              :workfavorites => { :only => [:id, :user_id, :venue_id] }
            }
          ) 
        } }
      end
    else
      
      # create
      @venue = Venue.create(params[:venue])

      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id], 
            :include => { 
              :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] } 
            }
          ) 
        } }
      end
    end
  end
end