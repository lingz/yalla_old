class Event < ActiveRecord::Base
  attr_accessible :description, :end_time, :user_id, :image,
    :location, :name, :start_time, :status, :unique_id, :ids,
    :user_event_id, :blurb

  has_many :comments, dependent: :destroy
  has_many :user_events, dependent: :destroy

  belongs_to :user

  validate :start_time_cannot_be_in_the_past, :end_time_cannot_be_before_start_time

  before_save :apply_filters

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

  def apply_filters
    match = self.description.match /http.*?\.(jpeg|jpg|gif|png)/ if self.description
    if match
      self.image = match[0]
      self.description = self.description.sub(match[0], "")
    end
    self.image = "/assets/nyudefault" + rand(1..11).to_s + ".jpg" if !self.image
    # generate the blurb
    if self.description
      if self.description.length > 140
        if self.description.index("\n") < 140
          self.blurb = self.description.split("\n")[0] + "..."
        else
          self.blurb = self.description[0...140] + "..."
        end
      else
        self.blurb = self.description
      end
    end
  end

end
