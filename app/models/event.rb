class Event < ActiveRecord::Base
  attr_accessible :description, :end_time, :user_id, :image,
    :location, :name, :start_time, :status, :unique_id

  has_many :comments

  belongs_to :user

  validate :start_time_cannot_be_in_the_past, :end_time_cannot_be_before_start_time

  def start_time_cannot_be_in_the_past
    if !start_time.blank? and start_time  < DateTime.now
      errors.add(:start_time, "cannot be in the past")
    end
  end

  def end_time_cannot_be_before_start_time
    if !end_time.blank? and end_time < start_time
      errors.add(:end_time, "cannot be before start time")
    end
  end
end
