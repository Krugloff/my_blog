#encoding: utf-8

class User < ActiveRecord::Base
  attr_accessible :name

  has_many :articles
  has_many :accounts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  validates :name, presence: true

  def owner?(a_model)
    a_model.user == self
  end
end
