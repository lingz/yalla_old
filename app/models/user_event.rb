class UserEvent < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :status, :email, :name

  belongs_to :event
end
