class Account < ActiveRecord::Base
  belongs_to :user

  validates :provider, :user_id,
    presence: true
end
