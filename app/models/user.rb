class User < ActiveRecord::Base
  attr_accessible :display_image, :name, :password, :school_id

  belongs_to :school

  has_many :emails
  has_many :events
  has_many :comments
end
