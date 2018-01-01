class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, except: [:index , :show]
  # before_action :correct_user,   only: [:destroy , :update]

  
  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.new(comment_params)
    @comment.user = current_user
    
    respond_to do |format|
      if @comment.save
        flash_message :success ,  'Comment was successfully created.'
        format.html { redirect_to @link }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        if @comment.errors.any? 
         @comment.errors.full_messages.each do |msg| 
          flash_message :danger ,  msg 
        end
      end

      format.html { redirect_to @link }
      format.json { render json: @comment.errors, status: :unprocessable_entity }
    end
  end
end


def destroy
  @link = @comment.link
  @comment.destroy
  respond_to do |format|
    flash_message :success ,  'Comment was successfully destroyed.'
    format.html { redirect_to  @link  }
    format.json { head :no_content }
  end
end

def upvote
  @link = Link.find(params[:link_id])
  @comment = @link.comments.find(params[:id])
  @upvotes = @comment.get_upvotes.size
  @comment.upvote_by current_user
  if @upvotes != @comment.get_upvotes.size 
    @user = @link.user
    @user.points += 0.2 
    @user.save    

  end

  respond_to do |format|
    format.html { redirect_back }
    format.json { head :no_content }
  end
end

def downvote
  @link = Link.find(params[:link_id])
  @comment = @link.comments.find(params[:id])
  @downvotes = @comment.get_downvotes.size
  @comment.downvote_from current_user
  if @downvotes != @comment.get_downvotes.size 
    @user = @link.user
    @user.points -= 0.2 
    @user.save    
  end

  respond_to do |format|
    format.html { redirect_back }
    format.json { head :no_content }
  end
end

private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
  end
