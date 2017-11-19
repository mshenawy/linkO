module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "LinkO"
    if page_title.empty?
      base_title
    else
      # page_title + " | " + base_title
      page_title
    end
  end

 def link_to_in_li(body, url, html_options = {})
  active = "nav-link" if current_page?(url)
  content_tag :a, class: active do
    link_to body, url, html_options
  end
end
  
def active_class(link_path)
  current_page?(link_path) ? "active" : ""
end

def upvoted_class(bool)
  bool? ? "upvoted" : ""
end

def link_to_in_li(body, url, html_options = {})
  active = "active" if current_page?(url)
  content_tag :li, class: active do
    link_to body, url, html_options
  end
end

end
