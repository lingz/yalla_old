class User < ActiveRecord::Base
  attr_accessible :display_image, :name, :password, :school_id, 
    :school, :provider, :uid, :netID, :nyu_class, :nyu_token, :email, :user, :remember_token, :visits

  belongs_to :school

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save :create_remember_token

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
    self.visits ||= 0
  end


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
      display_image: auth["info"]["image"],
      })
    user.save!
    nyuad.save!
    user
  end

  def self.create_with_netID(netID)
    response = JSON.parse HTTParty.get("http://passport.sg.nyuad.org/api/info/profile/#{netID}?client=W6zBUB3r2e90r0w24ts01seg3&secret=98j08jpiupiuy7dfy3yn").to_json
    # check if netID is valid
    if response["message"]
      return nil
    end
    nyuad = School.find_by_name("NYUAD")
    user = nyuad.users.create(name: response["name"], netID: netID,
                nyu_class: response["class"], email: "#{netID}@nyu.edu",
                display_image: '/assets/nyuad.jpg')
  end
end
