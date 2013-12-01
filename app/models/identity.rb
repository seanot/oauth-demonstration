class Identity < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :provider, scope: :user_id

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'].to_s)
  end

  def self.create_with_omniauth(auth, user)
    create(uid: auth['uid'], provider: auth['provider'], user_id: user.id)
  end
end
