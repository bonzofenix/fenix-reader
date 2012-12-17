class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation,
                  :remember_me, :provider, :uid
  
  # find_for_twitter and find_for_google
  def self.find_for_twitter(access_token)
    user = User.find_or_initialize_by_uid_and_provider(uid: access_token[:uid],
      provider: 'twitter', password: Devise.friendly_token[0,20],
      email: "twitter_user_#{access_token[:uid]}@fenix-reader.com")
    user.skip_confirmation! 
    user.save
    user
  end
end
