class Account < ActiveRecord::Base
  attr_accessible :uid, :provider

  belongs_to :user

  validates :uid, :provider, :user_id,
    presence: true
end
