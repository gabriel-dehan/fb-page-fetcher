module Facebook
  class Page < Facebook::Model
    def self.build page
      fb_page = Facebook::connect.get_object(page.fb_uid)
      page.tap do |p|
        # Required, thus we use fetch to raise an exception if they don't exist
        p.name  = fb_page.fetch(:name)
        p.likes = fb_page.fetch(:likes)

        # Optionals, thus we use regular access
        p.category = fb_page[:category]
        p.picture  = fb_page[:picture]
      end
    end
  end
end
