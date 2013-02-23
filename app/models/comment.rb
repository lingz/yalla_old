class Comment < ActiveRecord::Base
  attr_accessible :description, :event_id, :user_id

  belongs_to :event
  belongs_to :user
end
