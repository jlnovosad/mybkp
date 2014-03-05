class UsersController < ApplicationController
  before_filter :authenticate_user!

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
        :users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
          }
        ) 
      } }
    end
  end

  # for checking valid token and download user
  def valid

    puts '====================== valid'

    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
          }
        ) 
      } }
    end
  end

  #########################################
  # general info about any user
  #########################################

  # any user friends posts feed - for home tab
  def feed
    @title = "Latest Posts"

    puts '====================== feed'

    @user = User.find(params[:id])
    @feed_items = @user.feed.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
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

  # any user friends posts feed - bartenders only - for home tab
  def feedtender
    @title = "Latest Posts"

    puts '====================== feedtender'

    @user = User.find(params[:id])
    @feed_items = @user.feedtender.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
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

  # feed of the most popular users for promotion (followed by Mr. Popular user #2)
  def feedpopular
    @title = "Latest Posts"

    puts '====================== feedpopular'

    @user = User.find_by_email("mybarkeepers@lifestylesupply.co")
    @feed_items = @user.feedtender.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :feed_items=>@feed_items.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
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

  # viewing user profiles (user detaiL)
  def show
    @title = ""

    puts '====================== show'

    @user = User.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :drinks => { :only => [:id, :name] },
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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
    @microposts = @user.microposts.paginate(page: params[:page], :per_page => 50).includes(:user, :venue, :users)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :microposts=>@microposts.as_json(:only => [:id, :content, :created_at, :working], :methods => [:photo_url], 
          :include => { 
            :user => { :only => [:id, :name, :tender], :methods => [:photo_url],
              :include => { 
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
        :followed_users=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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

  # any user followers
  def followers
    @title = "Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('lower(name) ASC')


    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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

  # recent followers
  def recentfollowers
    @title = "Recent Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50).includes(:workvenues, :drinks).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
          }
        ) 
      } }
    end
  end

  # friend requests
  def friendrequests
    @title = "Friend Requests"
    
    puts '====================== friendrequests'

    @users = current_user.friendrequests.limit(50).includes(:workvenues, :drinks).order('relationships.updated_at DESC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
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
    <p>#{@name} has invited you to try out MyBarkeepers, a new app for iPhone that lets you stay in touch with your favorite bartenders.</p>
    <p>You and your friends can see who's working where and discover new drinking destinations. Bartenders can build their following and promote their latest concoction.</p>
    <br/>
    <p>Learn more and download the app for iPhone at <a href='https://www.mybarkeepers.com'>mybarkeepers.com</a>.</p>"

    # send email
    @sendmessage = Message.new(@message)
    if @sendmessage.valid?
      InvitationsMailer.new_message(@sendmessage).deliver
    end 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url])
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
        :user=>@user.as_json(:only => [:id, :name, :tender, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
          :include => { 
            :workvenues => { :only => [:id, :fs_venue_id, :name] }
          }
        ) 
      } }
    end
  end
  
end
