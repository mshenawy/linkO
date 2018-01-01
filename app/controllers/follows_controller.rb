class FollowsController < ApplicationController
		before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

	
  def create
    puts 'your debug message 1 -> ' + params[:following_id]
    @category = Category.find(params[:following_id])
    session[:selected_cat_id] = @category.id
    current_user.followCat(@category)
    respond_to do |format|
      format.html 
      format.js 
    end
  end

  def destroy
    puts 'your debug message 2 ->'
    if params[:following_id].nil?
      @category = Follow.find(params[:id]).following  
    else
      @category = Category.find(params[:following_id])
    end

      puts 'your debug message 4'
     puts  @category.id
    
    current_user.unfollowCat(@category)
    session[:selected_cat_id] =@category.id
    respond_to do |format|
      format.html { redirect_to categories_path }
      format.js
    end
   end

   # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash_message :danger ,  "برجاء تسجيل الدخول."
        redirect_to login_url
      end
    end

end
