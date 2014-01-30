class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  
  #########################################
  # favorite a venue
  #########################################
  def create
    @venue = Venue.find(params[:venue][:venue_id])
    current_user.favorite!(@venue)
    format.json  { render :json=> { 
      :venue=>@venue.as_json(:only => [:id, :fs_venue_id], 
        :include => { 
          :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
          :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] } 
        }
      ) 
    } }
  end

  #########################################
  # unfavorite
  #########################################
  def destroy
    @venue = Venue.find(params[:id]).venue_id
    current_user.unfavorite!(@venue)
    respond_to do |format|
      format.html {  }
      format.js
      format.json  { render :json=> { 
        :venue=>@venue.as_json(:only => [:id, :fs_venue_id], 
          :include => { 
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] },
            :tenders => { :only => [:id, :name, :tender], :methods => [:photo_url] } 
          }
        ) 
      } }
    end
  end
end