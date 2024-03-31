module ApplicationHelper
  def twitter_share_link(text, css_class = '')
    content_tag(:div, class: "flex items-center justify-center #{css_class}") do
      link_to "https://twitter.com/share?url=https://where-is-this.onrender.com/&text=#{CGI.escape(text)}" do
        content_tag(:i, '', class: 'fa-brands fa-x-twitter')
      end
    end
  end
end
