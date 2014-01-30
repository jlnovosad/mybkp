class DrinksController < ApplicationController
  before_filter :authenticate_user!

  #########################################
  # lists all the drinks that we have saved, not actually used
  #########################################
  def index
    @drinks = Drink.paginate(page: params[:page], :per_page => 50, :order => 'lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name],
          :include => { 
            :categories => @categories.as_json(:only => [:id, :name, :popular]) 
          } 
        )
      } }
    end
  end

  #########################################
  # lists all the drinks that we marked as popular
  #########################################
  def feedpopular
    @drinks = Drink.where(['popular = ?',"YES"]).order('lower(name) ASC').all
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name, :popular],
          :include => { 
            :categories => @categories.as_json(:only => [:id, :name, :popular]) 
          } 
        )
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
      @drinks = Drink.search(params[:search]).limit(50)
      if @drinks.nil?
        @drinks = []
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drinks=>@drinks.as_json(:only => [:id, :name, :popular],
          :include => { 
            :categories => @categories.as_json(:only => [:id, :name, :popular]) 
          } 
        )
      } }
    end
  end

  #########################################
  # creates new
  #########################################
  def create
    @user = current_user

    # exists?
    drinkname = params[:drink][:name];
    @drink = Drink.where('lower(name) LIKE ?', "%#{drinkname.downcase}%")
    if @drink.blank? 
      # created through user and the connection will already be there
      @drink = @user.drinks.create(params[:drink])
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular, :user_id],
          :include => { 
            :categories => { :only => [:id, :name, :popular] },
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] }
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
            :users => { :only => [:id, :name, :tender], :methods => [:photo_url] }
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
    @user = current_user
    @drink = Drink.find(params[:id])
    @user.drinks << @drink 
    
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular])
      } }
    end
  end

  #########################################
  # accesses the join table 
  #########################################
  def unfavorite
    @user = current_user
    @drink = Drink.find(params[:id])
    @user.drinks.delete(@drink)

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :drink=>@drink.as_json(:only => [:id, :name, :popular])
      } }
    end
  end
end