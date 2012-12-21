class User < ActiveRecord::Base
  has_many :channels
  has_many :feed_entries, through: :channels
   
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
                  :remember_me, :provider, :uid, :avatar_size
  
  def add_channel(url)
    self.channels.create(url: url) 
  end

  # find_for_twitter and find_for_google
  
  def self.find_for_google_oauth2(access_token)
    find_for_service(:google_oauth2, access_token[:uid])
  end

  def self.find_for_twitter(access_token)
    find_for_service(:twitter, access_token[:uid])
  end
  
  private
  
  def self.find_for_service(provider, uid)
    user = User.find_or_initialize_by_uid_and_provider(uid: uid ,
      provider: provider, password: Devise.friendly_token[0,20],
      email: "#{provider}_user_#{uid}@fenix-reader.com")
    user.skip_confirmation! 
    user.save
    user
  end
end
