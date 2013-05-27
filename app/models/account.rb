class Account < ActiveRecord::Base
  attr_accessible :uid, :provider

  belongs_to :user

  validates :uid, :provider, :user_id,
    presence: true

  def self.find_with_omniauth(auth_hash)
    where(auth_hash.slice :uid, :provider).first
  end

  def self.build_with_omniauth(auth_hash)
    new auth_hash.slice :uid, :provider
  end
end
