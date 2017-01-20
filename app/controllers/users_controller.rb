class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :microposts, :microposts_count, :following, :followers, :following_count, :followers_count, :venues, :drinks, :searchfollowing, :searchfollowers]

  #########################################
  # main
  #########################################

  # full list of users
  def index

    puts '====================== index'

    authorize! :index, @user, :message => 'Oops! Not authorized as an administrator.'
    @users = User.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @users.to_json }
    end
  end

  # search user names
  def search
    
    puts '====================== search'

    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.search(params[:search]).limit(50).includes(:workvenues, :drinks).order('lower(name) ASC')
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :venueprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # search one user email
  def searchemail
    
    puts '====================== searchemail'

    # get search term
    if params[:user][:email].nil?
      @user = []
    else 
      #@user = User.find_by_email(params[:user][:email])
      @user = User.searchbyemail(params[:user][:email]).includes(:workvenues, :drinks)
      if @user.nil?
        @user = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # for checking valid token and download user
  def valid

    puts '====================== valid'

    #@user = current_user
    @user = User.find_by_authentication_token(params[:auth_token])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { },
            :devices => { :only => [:id] }
          }
        ) 
      } }
    end
  end

  #########################################
  # general info about any user
  #########################################

  # any user friends posts feed 
  def feed
    @title = "Latest Posts"

    puts '====================== feed'

    #Micropost.current_user = current_user
    @user = User.find(params[:id])
    @feed_items = @user.feed.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
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

  # any user friends posts feed - bartenders only 
  def feedtender
    @title = "Latest Posts"

    puts '====================== feedtender'

    @user = User.find(params[:id])
    @feed_items = @user.feedtender.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
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

  # feed of the popular users for promotion 
  def feedpopular
    @title = "Latest Posts"

    puts '====================== feedpopular'

    @user = User.find(params[:id])
    @feed_items = @user.feedpopular.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
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

  # feed of nearby activity
  def feedlocal
    @title = "Latest Posts"

    puts '====================== feedlocal'

    @user = User.find(params[:id])
    @feed_items = @user.feedlocal.paginate(page: params[:page], :per_page => 50).includes(:user, :checkin, :likes, :comments, :users)
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

  # viewing user profiles (user detaiL)
  def show
    @title = ""

    puts '====================== show'

    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
          :include => { 
            :drinks => { :only => [:id, :name] },
            :workvenues => { :only => [:id, :fs_venue_id, :name], 
              :include => { 
                :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url],
                  :include => { 
                    :workvenues => { :only => [:id, :fs_venue_id, :name] },
                    :shifts => { }
                  }
                }
              } 
            },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # update notify (updates superuser)
  def refreshnotify
    @title = ""

    puts '====================== refreshnotify'

    current_user.update_attributes!(:notify => "NO")
    @user = current_user
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :location_id, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { },
            :devices => { :only => [:id] }
          }
        ) 
      } }
    end
  end

  # viewing user profiles (feed)
  def microposts
    @title = "Latest Posts"

    puts '====================== microposts'

    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 10).includes(:user, :checkin, :likes, :comments, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :microposts=>@microposts.as_json(:only => [:id, :content, :created_at, :working, :promo], :methods => [:photo_url, :thumb_url, :like_count, :comment_count],
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

  def microposts_count
    @mcount = User.find(params[:id]).microposts.count
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@mcount.as_json() 
        } }
    end
  end

  # any user favorite venues
  def venues
    @title = "Venues"

    puts '====================== venues'

    @user = User.find(params[:id])
    @venues = @user.venues.paginate(page: params[:page], :per_page => 50).includes(:users, :tenders)
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

  # any user favorite drinks
  def drinks
    @title = "Drinks"

    puts '====================== drinks'

    @user = User.find(params[:id])
    @drinks = @user.drinks
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json() 
      } }
    end
  end

  #########################################
  # relationships
  #########################################

  # any user following
  def following
    @title = "Bartenders"

    puts '====================== following'

    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
          :followed_users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url, :following_count],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  def following_count
    @fcount = User.find(params[:id]).followed_users.count
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@fcount.as_json() 
        } }
    end
  end

  # search following
  def searchfollowing
    
    puts '====================== search'

    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.find(params[:id]).searchfollowing(params[:search]).paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :venueprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # any user followers
  def followers
    @title = "Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  def followers_count
    @fcount = User.find(params[:id]).followers.count
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :modelcount=>@fcount.as_json() 
        } }
    end
  end

  # search followers
  def searchfollowers
    
    puts '====================== search'

    # get search term
    if params[:search].nil?
      @users = []
    else 
      @users = User.find(params[:id]).searchfollowers(params[:search]).paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :venueprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # recent followers
  def recentfollowers
    @title = "Recent Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # friend requests
  def friendrequests
    @title = "Friend Requests"
    
    puts '====================== friendrequests'

    @users = current_user.friendrequests.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  # check relationship
  def myrelationship

    puts '====================== myrelationship'

    user = User.find(params[:id])
    @relationship = current_user.following?(user)
    if @relationship.nil?
      @relationship = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :relationship=>@relationship.as_json() 
      } }
    end
  end

  # check reverse relationship
  def myreverserelationship

    puts '====================== myrelationship'

    user = User.find(params[:id])
    @relationship = user.following?(current_user)
    if @relationship.nil?
      @relationship = []
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :relationship=>@relationship.as_json() 
      } }
    end
  end

  # email someone already in the system
  def invitationemailonly

    puts '====================== invitationemailonly'

    # get user
    @user = User.find(params[:id])
    @email = @user[:email]

    # message object
    @message = {}
    @message = params[:message]
    @name = params[:message][:name]
    #@message.name = params[:message][:name]
    @message[:email] = @email
    @message[:subject] = "Let's Have a Drink..."
    @message[:body] = "
    <p>Hello #{@email}!</p>
    <br/>
    <p>#{@name} has invited you to try out Tipsly, a new app sthat lets you stay in touch with your favorite bartenders.</p>
    <p>You and your friends can see who's working where and discover new drinking destinations. Bartenders can build their following and promote their latest concoction.</p>
    <br/>
    <p>Learn more and download the app for iPhone at <a href='https://www.goodtimesapp.co'>goodtimesapp.co</a>.</p>"

    # send email
    @sendmessage = Message.new(@message)
    if @sendmessage.valid?
      InvitationsMailer.new_message(@sendmessage).deliver
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :phone, :email, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url])
        } }
    end
  end

  #########################################
  # block a user
  #########################################
  def blockuser

    # other user
    @user = User.find(params[:id])
    @relationship = @user.following?(current_user)
    if @relationship.nil?
      
      # create relationship
      @user.follow!(current_user, params[:relationship][:status])
    else

      # update
      @relationship.update_attributes!(:status => params[:relationship][:status])
      @user = User.find(@relationship.followed_id)
    end

    # done
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile, :bio], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] },
            :shifts => { }
          }
        ) 
      } }
    end
  end

  def blockuserrel # returns relationship object instead of user

    # other user
    @user = User.find(params[:id])
    @relationship = @user.following?(current_user)
    if @relationship.nil?
      
      # create relationship
      @user.follow!(current_user, params[:relationship][:status])
      @relationship = @user.following?(current_user)
    else

      # update
      @relationship.update_attributes!(:status => params[:relationship][:status])
      @user = User.find(@relationship.followed_id)
    end

    # done
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :relationship=>@relationship.as_json() 
      } }
    end
  end

  private

  #########################################
  # only you can perform actions 
  #########################################
  def correct_user
    @user = current_user
  end
  
end
