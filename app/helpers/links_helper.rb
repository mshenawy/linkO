require 'uri'
module LinksHelper

   # Returns the full title on a per-page basis.
  def link_score(link)
    link.get_upvotes.size - link.get_downvotes.size 
  end
    # Returns domain from URL.
  def URL_domain(url)
    URI.parse(url).host
  end

  # Returns the full title on a per-page basis.
  def link_comments(link)
    link.comments.count%2==0? link.comments.count.to_s+' تعليقات '  : link.comments.count.to_s+' تعليق ' 
  end

end
