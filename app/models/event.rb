class Event < ActiveRecord::Base
  attr_accessible :description, :end_time, :host_id, :image, :location, :name, :start_time, :status

  belongs_to :user
end
