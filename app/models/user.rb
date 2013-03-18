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


  #! Проверка выполняется только один раз. Поэтому требуемый аккаунт к данному моменту уже должен существовать. Его добавление не даст ожилаемого результата.
  def me?
    return @me unless @me.nil?
    @me = Rails.env.production? ?
    accounts.exists?( uid: '1621036', provider: 'github' ) :
    accounts.exists?( uid: '1234567890', provider: 'developer' )
  end
end
