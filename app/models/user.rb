class User < ActiveRecord::Base
  attr_accessible :display_image, :name, :password, :school_id, :school

  belongs_to :school

  has_many :emails
  has_many :events
  has_many :comments


  def self.authenticate(name, password)
    user = User.find_by_name(name)
    if !user
      return nil
    end
    if user.password == password
      return user
    else
      return nil
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.display_image = auth["info"]["image"]
    end
  end
  
end
