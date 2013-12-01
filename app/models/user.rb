class User < ActiveRecord::Base
  has_many :identities, :dependent => :destroy

  has_secure_password

  validates :email, presence: true, uniqueness: true

  def self.find_or_create_with_omniauth(auth)
    where(auth.slice(:info['email'])).first_or_initialize.tap do |user|
      user.name = auth.info.name
      user.email = auth.info.email if user.email == nil
      user.save!
    end
  end
end
