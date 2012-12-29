class Facebook::Feed < Facebook::Model
  has_many :comments
  belongs_to :page

  def self.build page
    comments = Facebook::connect.get_connections(page.fb_uid, 'feed', limit: 10)
    self.new(comments: comments, page: page)
  end

end

class Facebook::Comment < Facebook::Model
  has_one :author
  belongs_to :feed

  attr_accessor :fb_uid, :message, :likes, :shared, :picture, :link, :created_at, :updated_at

  def self.build comment
    self.new(author: comment['from']).tap do |c|
      c.fb_uid     = comment['id']
      c.message    = comment['message']
      # Implement maybe
      c.likes      = comment['likes']['count']  unless comment['likes'].nil?
      c.shared     = comment['shares']['count'] unless comment['shares'].nil?
      c.picture    = comment['picture']
      c.link       = comment['link']
      c.created_at = comment['created_time']
      c.updated_at = comment['updated_time']
    end
  end
end

class Facebook::Author < Facebook::Model
#  belongs_to :comment
  attr_accessor :fb_uid, :name, :picture

  def self.build author
    self.new.tap do |a|
      a.fb_uid  = author['id']
      a.name    = author['name']
      a.picture = Facebook::connect.get_picture(author['id'])
    end
  end
end
