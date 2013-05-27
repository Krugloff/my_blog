class Account < ActiveRecord::Base
  attr_accessible :uid, :provider, :name

  belongs_to :user

  validates :uid, :provider, :name, :user_id,
    presence: true

  def self.find_with_omniauth(auth_hash)
    where(uid: auth_hash.uid, provider: auth_hash.provider).first
  end

  def self.build_with_omniauth(auth_hash)
    new name: auth_hash.info.nickname || auth_hash.info.name,
        uid: auth_hash.uid,
        provider: auth_hash.provider
  end
end
