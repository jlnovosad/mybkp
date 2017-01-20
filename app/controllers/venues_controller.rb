class VenuesController < ApplicationController
  before_filter :authenticate_user!, :except => [:create, :publicfeed, :publicworkerfeed]

  #########################################
  # posts from tenders currently working
  #########################################
  def workerfeed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.workerfeed(current_user).paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :thumb_url, :like_count, :comment_count],
          :include => { 
            :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :checkin => { :only => [:id, :working],
              :include => { 
                :venue => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :likes => { :only => [:id, :user_id] }
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
    @feed_items = @venue.feed(current_user).paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :thumb_url, :like_count, :comment_count],
          :include => { 
            :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :checkin => { :only => [:id, :working],
              :include => { 
                :venue => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :likes => { :only => [:id, :user_id] }
          }
        )
      } }
    end
  end

  #########################################
  # public posts from tenders currently working
  #########################################
  def publicworkerfeed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.publicworkerfeed.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :thumb_url, :like_count, :comment_count],
          :include => { 
            :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :checkin => { :only => [:id, :working],
              :include => { 
                :venue => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :likes => { :only => [:id, :user_id] }
          }
        )
      } }
    end
  end

  #########################################
  # venue tagged in posts
  #########################################
  def publicfeed 
    @venue = Venue.find(params[:id])
    @feed_items = @venue.publicfeed.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :thumb_url, :like_count, :comment_count],
          :include => { 
            :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
              }
            },
            :venue => { :only => [:id, :fs_venue_id, :name] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :checkin => { :only => [:id, :working],
              :include => { 
                :venue => { :only => [:id, :fs_venue_id, :name] }
              }
            },
            :likes => { :only => [:id, :user_id] }
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
              :users => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url] },
              :tenders => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url],
                :include => { 
                  :workvenues => { :only => [:id, :fs_venue_id, :name] },
                  :shifts => { }
              } },
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
              :users => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url] },
              :tenders => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url],
                :include => { 
                  :workvenues => { :only => [:id, :fs_venue_id, :name] },
                  :shifts => { }
              } },
              :favorites => { :only => [:id, :user_id, :venue_id] },
              :workfavorites => { :only => [:id, :user_id, :venue_id] }
            }
          ) 
        } }
      end
    end
  end

  def venuesfromarray

    @venuearray = params[:venues]
    @returnvenues = []
    @venuearray.each do |v|

      @venue = Venue.includes(:tenders, :favorites, :workfavorites).find_by_fs_venue_id(v[:fs_venue_id])
      if @venue

        # if the venue was already in the db, return that entry so the app has the info anyway (refresh name first)
        @venue.update_attributes(name: v[:name])
        @returnvenues << @venue
      else
        
        # create
        @venue = Venue.includes(:tenders, :favorites, :workfavorites).create(v)
        @returnvenues << @venue
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venues=>@returnvenues.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :users => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url] },
            :tenders => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
            } },
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
  def favorite
    @venue = Venue.find(params[:id])
    current_user.favorite!(@venue)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
            } },
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
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
            } },
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
    if not current_user.workfavorited?(@venue)
      current_user.addworkplace!(@venue)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
            } },
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
    if not current_user.shifts.find_all_by_venue_id(@venue.id).nil?
      @deleteshifts = [] 
      @deleteshifts = current_user.shifts.find_all_by_venue_id(@venue.id)
      @deleteshifts.each do |s|
        s.destroy
      end
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id, :name], 
          :include => { 
            :tenders => { :only => [:id, :name, :tender, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] },
                :shifts => { }
            } },
            :favorites => { :only => [:id, :user_id, :venue_id] },
            :workfavorites => { :only => [:id, :user_id, :venue_id] }
          }
        ) 
      } }
    end
  end

end