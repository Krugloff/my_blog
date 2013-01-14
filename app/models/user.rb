#encoding: utf-8

class User < ActiveRecord::Base
  attr_accessible :name,
    :password,
    :password_confirmation

  has_secure_password

  has_many :comments, :dependent => :destroy
  has_many :articles

  validates :name,
    length: { maximum: 42, minimum: 3 },
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: /^[[:word:]\.'` ]+$/i }

  def owner?(a_model)
    a_model.user == self
  end
end
