class Facebook::Page < Facebook::Model
  # Public: Retrieves a facebook page and fill an object with informations.
  #
  # page - An Object with a fb_uid readable attribute, which will
  #        be used to retrieve the facebook page from which to build the object.
  #
  # Examples
  #
  #   # Considering the existance of a Facebook Page with an id 1234
  #   Facebook::Page::build(Page.new(fb_uid: '1234')
  #   # => #<Page:0x000000104dcdc8c7 @fb_uid="1234", @name="PageName", @likes=0, @category="Website", @picture=nil>
  #
  # Returns the Object passed as an argument, filled with informations.
  def self.build page
    # If we can't get the facebook page, we just return the original object, unfilled
    begin
      fb_page = Facebook::connect.get_object(page.fb_uid)
      fb_page['picture'] = Facebook::connect.get_picture(page.fb_uid)
    rescue
      return page
    else
      # We ensure we are retrieving a page and not a profile
      return page if fb_page['category'].nil? && fb_page['likes'].nil?
    end

    page.tap do |p|
      # Required, thus we use fetch to raise an exception if they don't exist (but they should)
      p.name  = fb_page.fetch('name')
      p.likes = fb_page.fetch('likes')

      # Optional, thus we use regular access
      p.category = fb_page['category']
      p.picture  = fb_page['picture']
    end
  end
end
