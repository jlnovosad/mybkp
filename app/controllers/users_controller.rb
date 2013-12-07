class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # main
  #########################################

  # full list of users
  def index

    puts '====================== index'

    authorize! :index, @user, :message => 'Oops! Not authorized as an administrator.'
    @users = User.paginate(page: params[:page], :per_page => 50)
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
      @users = User.search(params[:search]).limit(50)
      if @users.nil?
        @users = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {
        :users=>@users.as_json(:only => [:id, :name, :tender], :methods => [:photo_url])
      } }
    end
  end

  # search one user email
  def searchemail
    
    puts '====================== searchemail'

    # get search term
    if params[:email].nil?
      @user = []
    else 
      @user = User.find_by_email(params[:email])
      if @user.nil?
        @user = []
      end
    end

    # find
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token], :methods => [:photo_url])
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
        :user=>@user.as_json(:only => [:id, :name, :email, :tender], :methods => [:photo_url]) 
      } }
    end
  end

  # this method is PUT users#update at users/id.json
  # but to update a user use PUT registrations#update at users.json, custom devise method in registrations_controller.rb
  def update

    puts '====================== update'

    @user = User.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :email, :tender], :methods => [:photo_url]) 
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
    @feed_items = @user.feed.paginate(page: params[:page], :per_page => 50)
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

  # any user friends posts feed - bartenders only - for home tab
  def feedtender
    @title = "Latest Posts"

    puts '====================== feedtender'

    @user = User.find(params[:id])
    @feed_items = @user.feedtender.paginate(page: params[:page], :per_page => 50)
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

  # feed of the most popular users for promotion (followed by Mr. Popular user #2)
  def feedpopular
    @title = "Latest Posts"

    puts '====================== feedpopular'

    @user = User.find_by_email("mybarkeepers@lifestylesupply.co")
    @feed_items = @user.feedtender.paginate(page: params[:page], :per_page => 50)
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

  # viewing user profiles (user detaiL)
  def show
    @title = ""

    puts '====================== show'

    #@user = User.joins(:reverse_relationships).where("relationships.follower_id" => current_user.id).find(params[:id])
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender], :methods => [:photo_url]) 
        } }
    end
  end

  # viewing user profiles (feed)
  def microposts
    @title = "Latest Posts"

    puts '====================== microposts'

    @microposts = User.find(params[:id]).microposts.paginate(page: params[:page], :per_page => 50).as_json(:only => [:content, :created_at], :methods => [:photo_url], 
      :include => { 
        :user => { :only => [:id, :name, :tender], :methods => [:photo_url] }, 
        :venue => { :only => [:id, :fs_venue_id] }
      }
    )
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {
        :microposts=>@microposts.as_json()
      } }
    end
  end

  # friend requests
  def friendrequests
    @title = "Friend Requests"
    
    puts '====================== friendrequests'

    @users = User.find(params[:id]).friend_requests
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :tender], :methods => [:photo_url])
        } }
    end
  end

  # any user favorite venues
  def venues
    @title = "Venues"

    puts '====================== venues'

    @venues = User.find(params[:id]).venues.paginate(page: params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => {
        :venues=>@venues.as_json(:only => [:id, :fs_venue_id])
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

    @users = User.find(params[:id]).followed_users.paginate(page: params[:page], :per_page => 50, :order => "name ASC")
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json  { render :json=> { 
        :followed_users=>@users.as_json(:only => [:id, :name, :tender], :methods => [:photo_url]) 
        } }
    end
  end

  # any user followers
  def followers
    @title = "Followers"

    puts '====================== followers'

    @users = User.find(params[:id]).followers.paginate(page: params[:page], :per_page => 50, :order => "name ASC")
    respond_to do |format|
      format.html { render 'show_follow' }
      format.json  { render :json=> { 
        :followers=>@users.as_json(:only => [:id, :name, :tender], :methods => [:photo_url] ) 
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

  # email someone already in the system
  def invitationemailonly

    puts '====================== invitationemailonly'

    @user = User.find(params[:message][:user_id])
    
    # send email
    @message = Message.new(params[:message])
    if @message.valid?
      InvitationsMailer.new_message(@message).deliver
    end
    
    # follow user, they already exist
    current_user.follow!(@user, "FOLLOWING")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :user=>@user.as_json(:only => [:id, :name, :tender, :email, :invitation_token], :methods => [:photo_url])
        } }
    end
  end

end
