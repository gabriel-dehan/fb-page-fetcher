module ApplicationHelper

  # Public: generates a title for the current page
  #
  # title - A title for the page (default: current action name)
  #
  # Returns the full title as a String.
  def get_title(title = nil)
    application_name = 'PageFetcher'
    title = action_name.capitalize if title.nil? && !action_name.nil?
    (action_name.nil? && title.nil?) ? application_name : "#{ application_name} | #{title}"
  end
end
