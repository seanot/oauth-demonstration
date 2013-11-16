class User < ActiveRecord::Base
  has_many :identities

  def self.find_or_create_with_omniauth(auth)
    where(auth.slice(:info['email'])).first_or_initialize.tap do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.save!
    end
  end
end
