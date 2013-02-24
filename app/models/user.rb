class User < ActiveRecord::Base
  attr_accessible :display_image, :name, :password, :school_id, :school, :provider, :uid, :user

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
    nyuad = School.find_by_name("NYUAD")
    user = nyuad.users.create({
      provider: auth["provider"],
      uid: auth["uid"],
      name: auth["info"]["name"],
      display_image: auth["info"]["image"]
      })
    user.save!
    nyuad.save!
    user
  end
  
end
