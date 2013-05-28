class User < ActiveRecord::Base
  attr_accessible :name

  has_many :articles
  has_many :accounts, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  validates :name, presence: true

  def owner?(a_model)
    self.id.eql? a_model.respond_to?(:user_id) ? a_model.user_id : a_model.id
  end

  #! Проверка выполняется только один раз. Поэтому требуемый аккаунт к данному моменту уже должен существовать. Его добавление не даст ожидаемого результата.
  def admin?
    return @is_admin unless @is_admin.nil? # may be false.
    @is_admin = Rails.env.production? ?
    accounts.exists?( uid: '1621036', provider: 'github' ) :
    accounts.exists?( uid: '1234567890', provider: 'developer' )
  end
end
