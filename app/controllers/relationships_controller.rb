class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  
  #########################################
  # follow another user
  #########################################
  def create

    # other user
    @user = User.find(params[:relationship][:followed_id])

    # create relationship
    current_user.follow!(@user, params[:relationship][:status])
    @user.update_attributes!(:notify => "YES", :name => @user.email)
    
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

  #########################################
  # update relationship (keep the record)
  #########################################
  def updatestatus

    # other user
    @relationship = Relationship.find(params[:id])
    status = params[:relationship][:status]
    
    # create relationship
    if current_user.id == @relationship.follower_id 

      @relationship.status = status
      @relationship.save
      @user = User.find(@relationship.followed_id)
      if status == "FOLLOWING" || status == "REQUEST"
        @user.update_attributes!(:notify => "YES")
      end

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
  end

  #########################################
  # confirm a follow
  #########################################
  def confirmfollow

    # other user
    @relationship = Relationship.find(params[:id])
    status = params[:relationship][:status]
    
    # create relationship
    if current_user.id == @relationship.followed_id 

      @relationship.status = status
      @relationship.save
      @user = User.find(@relationship.follower_id)

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
  end

end