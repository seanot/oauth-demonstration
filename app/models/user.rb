class User < ActiveRecord::Base
  has_many :identities, :dependent => :destroy
  accepts_nested_attributes_for :identities
  has_secure_password

  validates :email, presence: true, uniqueness: true

end
