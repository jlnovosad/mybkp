class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # create a new status
  # pass user_id, content
  #########################################
  def create
    @user = current_user
    @micropost = @user.microposts.build(params[:micropost])
    if @user.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :micropost=>@micropost.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
            :include => { 
              :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
                :include => { 
                  :drinks => { :only => [:id, :name] },
                  :workvenues => { :only => [:id, :fs_venue_id] },
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
              :likes => { :only => [:id] },
              :comments => { :only => [:id, :content] } 
            }
          )
        } }
      end
    end
  end

  #########################################
  # detail
  #########################################
  def show
    @micropost = Micropost.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
        format.json  { render :json=> { 
          :micropost=>@micropost.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :like_count, :comment_count],
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
              :likes => { :only => [:id, :user_id], 
                :include => { 
                  :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
                    :include => { 
                      :workvenues => { :only => [:id, :fs_venue_id, :name] }
                    }
                  }
                }
              },
              :comments => { :only => [:id, :content, :created_at], 
                :include => { 
                  :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
                    :include => { 
                      :workvenues => { :only => [:id, :fs_venue_id, :name] },
                      :shifts => { }
                    }
                  }
                }
              } 
            }
          )
        } }
    end
  end

  #########################################
  # tags a user
  #########################################
  def taguser
    @user = User.find(params[:user][:id])
    @micropost = Micropost.find(params[:id])
    @micropost.users << @user 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :micropost=>@micropost.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url])
      } }
    end
  end

  #########################################
  # destroys the post
  #########################################
  def destroy
    @micropost.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @micropost.as_json() } 
    end
  end

  private

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @micropost = current_user.microposts.find_by_id(params[:id])
    redirect_to root_url if @micropost.nil?
  end
  
end