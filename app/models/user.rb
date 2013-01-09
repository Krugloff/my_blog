class User < ActiveRecord::Base
  attr_accessible :name,
    :password,
    :password_confirmation

  has_secure_password

  has_many :comments
  has_many :articles

  validates :name,
    length: { maximum: 42 },
    presence: true,
    uniqueness: { case_sensitive: false }

  def owner?(a_model)
    a_model.user == self
  end
end
