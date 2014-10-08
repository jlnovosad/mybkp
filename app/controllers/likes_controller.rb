class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # create
  #########################################
  def create
    @user = current_user
    @like = @user.likes.build(params[:like])
    if @user.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :like=>@like.as_json()
        } }
      end
    end
  end

  #########################################
  # destroy
  #########################################
  def destroy
    @like.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @like.as_json() } 
    end
  end

  private

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @like = current_user.likes.find_by_id(params[:id])
    redirect_to root_url if @like.nil?
  end
  
end