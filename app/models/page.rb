class Page < ActiveRecord::Base
  attr_accessible :fb_uid, :name, :category, :picture, :likes

  validates :fb_uid,   presence: true
  validates :name,     presence: true
  validates :likes,    presence: true,  numericality: true
end
