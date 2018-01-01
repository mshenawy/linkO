class RelationshipsController < ApplicationController
	before_action :logged_in_user

	
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
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
