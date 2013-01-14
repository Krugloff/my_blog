class Article < ActiveRecord::Base
  attr_accessible :title, :body

  # TODO: before_save :body_to_html

  has_many :comments
  belongs_to :user

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user,
    presence: true

  private

  # TODO
  # def body_to_html
  #   # Redcarpet.handle(article.body)
  # end
end
