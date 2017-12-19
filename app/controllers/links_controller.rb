class LinksController < ApplicationController
  # before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:index , :show,:vote_notLogin ]
  before_action :correct_user,   only: [:destroy , :update]
  before_action :logged_in_user_vote, only: [:vote_notLogin ]
  # GET /links
  # GET /links.json
  def index
    # if params[:category].blank?
    #     # @links = Link.all.order("created_at DESC")  
    #   else
    #     @category_id = Category.find_by(name: params[:category]).id
    #     # @links = Link.where(category_id: @category_id).order("created_at DESC")
    # end
    @links = recent_posts
    puts @links.size      # => debug
    respond_to :html, :json
    
  end

   def search
    if params[:search].present?
      @links = Link.search(params[:search])
    else
      @links = Link.all
    end
  end

   def recent_posts
    @skip = 0
    @category = nil
    if params[:category].blank?
      @skip = 1 
    else 
      @category = Category.find_by(name: params[:category])
    end
    
    if params[:category].present?
      logger.info(params[:category])
    links = Link.where("category_id= ?" , @category.id) 
    else
      links = Link.all
    end
    links = links.where("created_at >= ?" , 1.hour.ago.utc) if params[:t] == "hour"
    links = links.where("created_at >= ?" , 1.day.ago.utc) if params[:t] == "day"
    links = links.where("created_at >= ?" , 1.week.ago.utc) if params[:t] == "week"
    links = links.where("created_at >= ?" , 1.month.ago.utc) if params[:t] == "month"
    links = links.where("created_at >= ?" , 1.year.ago.utc) if params[:t] == "year"
    links = links.order(:cached_weighted_score => :desc,:created_at => :DESC)  

  end


  def update_links
     @category_id = Category.find_by(name: params[:category]).id
     if params[:t] =="day"
      @links = Link.where("created_at >= ?", 1.day.ago.utc)    
     end
    respond_to do |format|
      format.js
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  # GET /links/new
  def new
    @link = current_user.links.build
  end

  # GET /links/1/edit
  def edit
     @link = Link.find(params[:id])
  end

  def create
    @link = current_user.links.build(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def vote_notLogin
    
  end

  def upvote
# check if user login
    @link = Link.find(params[:id])
    # @upvotes = @link.get_upvotes.size
    @liked = false
    if (current_user.voted_as_when_voted_for @link).nil?  
       @link.liked_by current_user
       @liked = true
     elsif (current_user.voted_as_when_voted_for @link) # => true, user liked it
       @link.unliked_by current_user    
       @liked = false
      else
        @link.liked_by current_user
       @liked = true
    end
    
    if @liked 
      @user = @link.user
      @user.points += 0.2 
      @user.save  
    else
      @user = @link.user
      @user.points -= 0.2 
      @user.save        
    end 
    respond_to do |format|
          format.html
          format.js 
        end
  end

  def downvote
    @link = Link.find(params[:id])
    # @upvotes = @link.get_upvotes.size
    @disliked = false
    if (current_user.voted_as_when_voted_for @link).nil?  
       @link.disliked_by current_user
       @disliked = true
     elsif not(current_user.voted_as_when_voted_for @link) # => true, user liked it
       @link.undisliked_by current_user    
       @disliked = false
     else
       @link.disliked_by current_user
       @disliked = true
    end
  
    if @disliked 
      @user = @link.user
      @user.points -= 0.2 
      @user.save  
    else
      @user = @link.user
      @user.points += 0.2 
      @user.save        
    end

    respond_to do |format|
      format.html
      format.js 
    end
  end


  private
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:title, :url,:category_id,:image)
    end

    def correct_user
      @link = current_user.links.find_by(id: params[:id])
      redirect_to root_url, notice: "Not authorized to edit this link" if @link.nil?
    end

    def find_link
      @link = Link.find(params[:id])
    end

    # Confirms a logged-in user.
    def logged_in_user_vote
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to root_url

      end
    end
end
