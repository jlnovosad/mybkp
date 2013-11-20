class MicropostsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # create a new status
  # pass user_id, content
  #########################################
  def create
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> @micropost.as_json(:only => [:content, :venue_id, :created_at]) } 
      end
    else
      flash[:success] = "Micropost failed!"
      redirect_to root_url
    end
  end

  #########################################
  # destroys the post
  #########################################
  def destroy
    @micropost.destroy
    redirect_to root_url
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