class Facebook::Comment < Facebook::Model
  has_one :author
  belongs_to :feed

  attr_accessor :fb_uid, :message, :likes, :shared, :picture, :link, :created_at, :updated_at

  def self.build comment
    self.new(author: comment['from']).tap do |c|
      c.fb_uid     = comment['id']
      c.message    = comment['message']
      c.likes      = comment.maybe['likes']['count'].value
      c.shared     = comment.maybe['shares']['count'].value
      c.picture    = comment['picture']
      c.link       = comment['link']
      c.created_at = comment['created_time']
      c.updated_at = comment['updated_time']
    end
  end
end
