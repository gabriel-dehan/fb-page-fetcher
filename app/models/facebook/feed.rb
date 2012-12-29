class Facebook::Feed < Facebook::Model
  has_many :comments

  def self.build page
    comments = Facebook::connect.get_connections(page.fb_uid, 'feed', limit: 10)
    self.new(comments: comments)
  end
end
