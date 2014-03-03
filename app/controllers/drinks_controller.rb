class DrinksController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user, only: [:tagdrink, :untagdrink]

  #########################################
  # lists all the drinks that we have saved not actually used
  #########################################
  def index
    @drinks = Drink.limit(50).order('lower(name) ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] }
          } 
        )
      } }
    end
  end

  #########################################
  # lists all the drinks that we marked as popular
  #########################################
  def feedpopular
    @drinks = Drink.where(['popular = ?',"YES"]).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name, :popular])
      } }
    end
  end

  #########################################
  # lists all the drinks based on user search string
  #########################################
  def search
    
    # get search term
    if params[:search].nil?
      @drinks = []
    else 
      @drinks = Drink.search(params[:search]).limit(50).order('lower(name) ASC')
      if @drinks.nil?
        @drinks = []
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name, :popular])
      } }
    end
  end

  #########################################
  # creates new
  #########################################
  def create
    
    # exists as a drink
    name = params[:drink][:name];
    @drink = Drink.find(:first, :conditions => ["lower(name) = ?", name.downcase]) 
    if @drink.blank? 
      
      # created through user and the connection will already be there
      @drink = current_user.drinks.create(params[:drink])
    else 

      # already favorited?
      favoritedrink = current_user.drinks(:id).find_by_id(@drink.id)

      if favoritedrink.nil? 
        current_user.drinks << @drink
      end
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  #########################################
  # drink detail and tenders
  #########################################
  def show
    @drink = Drink.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  def drinkusers
    @drink = Drink.find(params[:id])
    @users = @drink.drinkusers

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :users=>@users.as_json(:only => [:id, :name, :tender], :methods => [:photo_url])
      } }
    end
  end

  #########################################
  # accesses the join table
  #########################################
  def favorite
    @drink = Drink.find(params[:id])
    current_user.drinks << @drink
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  #########################################
  # accesses the join table 
  #########################################
  def unfavorite
    @drink = Drink.find(params[:id])
    current_user.drinks.destroy(@drink)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  #########################################
  # tags a drink with a category
  #########################################
  def tagdrink
    @category = Category.find(params[:category][:id])
    @drink = Drink.find(params[:id])
    @drink.categories << @category 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  #########################################
  # untags a drink with a category
  #########################################
  def untagdrink
    @category = Category.find(params[:category][:id])
    @drink = Drink.find(params[:id])
    @drink.categories.delete(@category)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender, :email, :invitation_token, :notify, :privateprofile], :methods => [:photo_url],
              :include => { 
                :workvenues => { :only => [:id, :fs_venue_id, :name] }
              }
            }
          }
        )
      } }
    end
  end

  #########################################
  # only you can perform actions on your stuff
  #########################################
  def correct_user
    @drink = current_user.drinks.find_by_id(params[:id])
    redirect_to root_url if @drink.nil?
  end

end