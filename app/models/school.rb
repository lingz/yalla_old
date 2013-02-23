class School < ActiveRecord::Base
  attr_accessible :image, :name

  has_many :users
end
