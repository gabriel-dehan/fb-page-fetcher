require 'time'

module PagesHelper
  def get_time time_string
    time_ago_in_words(Time::parse(time_string))
  end

  def maybe_nil v
    v.nil? ? 0 : v
  end

  def display_content_for comment
    if comment.picture != nil
      image   = link_to image_tag(comment.picture), comment.link
      message = comment.message
      return image + message
    else
      message = link_to comment.message, comment.link
    end
  end
end
