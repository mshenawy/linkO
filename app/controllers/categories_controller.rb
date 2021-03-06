class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:destroy , :update]
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    category = Category.find_by_name(params[:name])
    @links = recent_posts
  end

  def recent_posts
    @skip = 0
    category = Category.find_by_name(params[:name])
    
    links = Link.where("category_id= ?" , category.id) 
    links = links.where("created_at >= ?" , 1.hour.ago.utc) if params[:t] == "hour"
    links = links.where("created_at >= ?" , 1.day.ago.utc) if params[:t] == "day"
    links = links.where("created_at >= ?" , 1.week.ago.utc) if params[:t] == "week"
    links = links.where("created_at >= ?" , 1.month.ago.utc) if params[:t] == "month"
    links = links.where("created_at >= ?" , 1.year.ago.utc) if params[:t] == "year"
    links = links.order(:cached_weighted_score => :desc,:created_at => :DESC)  

  end
  # GET /categories/new
  def new
    # @category = Category.new
    @category = current_user.categories.build
    @link = current_user.links.build
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    # @category = Category.new(category_params)
    @category = current_user.categories.build(category_params)
    # @category.user = current_user
    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_path }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        flash_message :success ,  "Category was successfully updated." 
        format.html { redirect_to @category }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy

    @category.destroy
    respond_to do |format|
      flash_message :success ,  "Category was successfully destroyed." 
      format.html { redirect_to categories_url  }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by_name(params[:name])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name,:arabic_name, :about, :image)
    end


    def correct_user
      @category = current_user.categories.find_by_name(params[:name])
      if @category.nil?
        flash_message :danger ,  "Not authorized to edit this category" 
        redirect_to @category
      end

    end

  end
