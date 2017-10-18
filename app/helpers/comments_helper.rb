module CommentsHelper

# Returns the full title on a per-page basis.
  def comment_score(comment)
    comment.get_upvotes.size - comment.get_downvotes.size 
  end
  
end
