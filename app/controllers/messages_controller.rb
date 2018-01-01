class MessagesController < ApplicationController
  before_action :logged_in_user, only: [:destroy , :create]
  before_action :correct_user,   only: :destroy

  def index
        if logged_in?
      @micropost  = current_user.microposts.build
      @message  = current_user.messages.build
      @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 10)
    end
  end

  def create
     
   if logged_in?
       @message = current_user.messages.build(message_params)
       @message.sender = current_user.id
    else
      @user = User.find(params[:user_id])
      @message  = @user.messages.build(message_params) 
    end

      if @message.save
        flash_message :success ,  "Message sent successfully !"
        redirect_to :back 
      else
        if @message.errors.any?
           @message.errors.full_messages.each do |single|
             flash_message :danger ,  single
           end
         end
        redirect_to :back 
      end
    
  end



  def destroy
    @message.destroy
    flash_message :success ,  "Message deleted"
    redirect_to request.referrer || root_url
  end

  private
    
    def message_params
      params.require(:message).permit(:content,:sender)
    end

    def correct_user
      @message = current_user.messages.find_by(id: params[:id])
      redirect_to root_url if @message.nil?
    end

end
