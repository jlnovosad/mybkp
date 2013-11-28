class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  
  #########################################
  # follow another user
  #########################################
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user, params[:relationship][:status])
    respond_to do |format|
      format.html { redirect_to @user }
      format.js 
      format.json  { render :json => {
        :user=>@user.as_json(:only => [:id, :name, :tender, :email], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
      } }
    end
  end

  #########################################
  # update relationship (keep the record)
  #########################################
  def updatestatus
    @relationship = Relationship.find(params[:id])
    @user = @relationship.followed
    if current_user.id == @relationship.follower_id 
      @relationship.status = params[:relationship][:status]
      @relationship.save
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
        format.json  { render :json => {
          :user=>@user.as_json(:only => [:id, :name, :tender, :email], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id, :status ] }} )
        } }
      end
    else
      redirect_to root_url
    end
  end

  #########################################
  # stop following someone
  #########################################
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
      format.json { render :json => @user }
    end
  end
end