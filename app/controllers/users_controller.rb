class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers ]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  # GET /users
  # GET /users.json
  def index
    #@users = User.all
    @users = User.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
   @user = User.find_by_username(params[:username])
     # @links = Link.where(user_id: @user.id).order("created_at DESC")
     @links = recent_posts
     respond_to :html, :json

   #    if logged_in?
   #    @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 10)
   #    @message  = current_user.messages.build
   # end
 end

 def recent_posts
   @user = User.find_by_username(params[:username])
   @links = Link.where(user_id: @user.id)
   if params[:t] == "hour"
    @links = @links.where("created_at >= ?", 1.hour.ago.utc).order(:cached_weighted_score => :desc,:created_at => :DESC)  
  elsif  params[:t] == "day"
    @links = @links.where("created_at >= ?", 1.day.ago.utc).order(:cached_weighted_score => :desc,:created_at => :DESC)  
  elsif params[:t] == "week"
    @links = @links.where("created_at >= ?", 1.week.ago.utc).order(:cached_weighted_score => :desc,:created_at => :DESC)  
  elsif params[:t] == "month"
    @links = @links.where("created_at >= ?", 1.month.ago.utc).order(:cached_weighted_score => :desc,:created_at => :DESC)  
  elsif params[:t] == "year"
    @links = @links.where("created_at >= ?", 1.year.ago.utc).order(:cached_weighted_score => :desc,:created_at => :DESC)  
  else
    @links = @links.all.order(:cached_weighted_score => :desc,:created_at => :DESC)  
  end
end
  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by_username(params[:username])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      # activate without send email ..
      @user.activate
      log_in @user
      flash_message :success, "Account activated!"
      # redirect_to @user
      # @user.send_activation_email
      # flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    # flash_message :success ,  "Welcome to the Sample App!"
    # redirect_to @user
  else
    if @user.errors.any? 
     @user.errors.full_messages.each do |msg| 
      flash_message :danger, msg
    end

  end
  render 'new'
end
end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
   @user = User.find_by_username(params[:username])
   if @user.update_attributes(user_update_params)
      # Handle a successful update.
      @links = recent_posts
      respond_to :html, :json
      render 'show'
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find_by_username(params[:username]).destroy
    flash_message :success ,  "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find_by_username(params[:username])
    @users = @user.following.paginate(:page => params[:page], :per_page => 5)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find_by_username(params[:username])
    @users = @user.followers.paginate(:page => params[:page], :per_page => 5)
    render 'show_follow'
  end

  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_username(params[:username])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email,:username, :password, :password_confirmation,:image)
    end

    def user_update_params
      params.require(:user).permit(:name, :email, :username, :bio,:location ,:image)
    end
    # Before filters


    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash_message :danger ,  "برجاء تسجيل الدخول."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find_by_username(params[:username])
      redirect_to(root_url) unless current_user?(@user)
    end

  end
