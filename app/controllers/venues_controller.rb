class VenuesController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # lists all the venues that we have saved, not actually used
  #########################################
  def index
    @venues = Venue.paginate(page: params[:page], :per_page => 50).includes(:tenders, :favorites, :workfavorites).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venues=>@venues.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

  #########################################
  # posts from tenders currently working
  #########################################
  def workerfeed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.workerfeed.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
                :drinks => { :only => [:id, :name] },
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] }  
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
    @feed_items = @venue.feed.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
                :drinks => { :only => [:id, :name] },
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] }  
          }
        )
      } }
    end
  end
  
  #########################################
  # creates a new venue or finds the existing
  #########################################
  def create
    @venue = Venue.includes(:tenders, :favorites, :workfavorites).find_by_fs_venue_id(params[:venue][:fs_venue_id])
    if @venue

      # if the venue was already in the db, return that entry so the app has the info anyway (refresh name first)
      @venue.update_attributes(name: params[:venue][:name])

      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
            :include => { 
              :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :favorites => { :only => [:id, :user_id, :venue_id] },
              :workfavorites => { :only => [:id, :user_id, :venue_id] }
            }
          ) 
        } }
      end
    else
      
      # create
      @venue = Venue.includes(:tenders, :favorites, :workfavorites).create(params[:venue])

      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
            :include => { 
              :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
              :favorites => { :only => [:id, :user_id, :venue_id] },
              :workfavorites => { :only => [:id, :user_id, :venue_id] }
            }
          ) 
        } }
      end
    end
  end

  #########################################
  # accesses favorite join table
  #########################################
  def favorite
    @venue = Venue.find(params[:id])
    current_user.favorite!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

  #########################################
  # accesses favorite join table
  #########################################
  def unfavorite
    @venue = Venue.find(params[:id])
    current_user.unfavorite!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

  #########################################
  # accesses work favorite join table
  #########################################
  def workfavorite
    @venue = Venue.find(params[:id])
    current_user.addworkplace!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

  #########################################
  # accesses work unfavorite join table
  #########################################
  def workunfavorite
    @venue = Venue.find(params[:id])
    current_user.removeworkplace!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

end