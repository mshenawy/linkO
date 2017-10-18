class FollowsController < ApplicationController
		before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

	
  def create
    @category = Category.find(params[:following_id])
    session[:selected_cat_id] =@category.id
    current_user.followCat(@category)
    respond_to do |format|
      format.html { redirect_to @category }
      format.js 
    end
  end

  def destroy
    @category = Follow.find(params[:id]).following
    current_user.unfollowCat(@category)
    session[:selected_cat_id] =@category.id
    respond_to do |format|
      format.html { redirect_to @category }
      format.js
    end
   end

   # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "برجاء تسجيل الدخول."
        redirect_to login_url
      end
    end

end
