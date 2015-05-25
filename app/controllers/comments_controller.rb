class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :correct_user,   only: :destroy

  #########################################
  # create
  #########################################
  def create
    @user = current_user
    @comment = @user.comments.build(params[:comment])
    if @user.save
      respond_to do |format|
        format.html # index.html.erb
        format.json  { render :json=> { 
          :comment=>@comment.as_json(:only => [:id, :content, :created_at], 
            :include => { 
              :user => { :only => [:id, :name, :tender, :venueprofile], :methods => [:photo_url],
                :include => { 
                  :workvenues => { :only => [:id, :fs_venue_id, :name] },
                  :shifts => { }
                }
              }
            } 
          )
        } }
      end
    end
  end

  #########################################
  # destroy
  #########################################
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> @comment.as_json() } 
    end
  end

  private

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_url if @comment.nil?
  end
  
end