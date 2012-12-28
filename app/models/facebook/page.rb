require_relative 'facebook'

module Facebook
  class Page < Facebook::Model
    def self.build page
      # If we can't get the facebook page, we just return the original object, unfilled
      begin
        ap page.fb_uid
        fb_page = Facebook::connect.get_object(page.fb_uid)
      rescue
        return page
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
end
