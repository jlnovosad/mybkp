class CategoriesController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  #########################################
  # lists all the categories that we have saved, not actually used
  #########################################
  def index
    @categories = Category.limit(50).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :categories => @categories.as_json(:only => [:id, :name, :popular],
          :include => { 
            :drinks => { :only => [:id, :name, :popular] }
          }
        )
      } }
    end
  end

  #########################################
  # lists all the categories that we have marked as popular
  #########################################
  def feedpopular
    @categories = Category.where(['popular = ?',"YES"]).order('lower(name) ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :categories => @categories.as_json(:only => [:id, :name, :popular],
          :include => { 
            :drinks => { :only => [:id, :name, :popular] }
          }
        )
      } }
    end
  end

  #########################################
  # searches categories based on user string, UNUSED
  #########################################
  def search
    
    # get search term
    if params[:search].nil?
      @categories = []
    else 
      @categories = Category.search(params[:search]).limit(50)
      if @categories.nil?
        @categories = []
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :categories => @categories.as_json(:only => [:id, :name, :popular],
          :include => { 
            :drinks => { :only => [:id, :name, :popular] }
          }
        )
      } }
    end
  end

  #########################################
  # creates new
  #########################################
  def create

    name = params[:category][:name];
    @category = Category.find(:first, :conditions => ["lower(name) = ?", name.downcase]) 
    if @category.blank? 
      @category = Category.create(params[:category])
    end
      
    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :category => @category.as_json(:only => [:id, :name, :popular],
          :include => { 
            :drinks => { :only => [:id, :name, :popular] }
          }
        )
      } }
    end
  end

  #########################################
  # detail and drinks
  #########################################
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json=> { 
        :category => @category.as_json(:only => [:id, :name, :popular],
          :include => { 
            :drinks => { :only => [:id, :name, :popular] }
          }
        )
      } }
    end
  end

end