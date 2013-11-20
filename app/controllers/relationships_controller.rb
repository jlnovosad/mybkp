class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  
  #########################################
  # follow another user
  #########################################
  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js 
      format.json  { render :json => {
        :user=>@user.as_json(:only => [:id, :name, :tender, :email], :methods => [:photo_url], :include => {:reverse_relationships => { :only => [:id, :followed_id, :follower_id ] }} )
      } }
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