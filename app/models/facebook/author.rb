class Facebook::Author < Facebook::Model
  belongs_to :comment

  attr_accessor :fb_uid, :name, :picture

  def self.build author
    self.new.tap do |a|
      a.fb_uid  = author['id']
      a.name    = author['name']
      a.picture = Facebook::connect.get_picture(author['id'])
    end
  end
end
