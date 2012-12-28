class Article < ActiveRecord::Base
  attr_accessible :title, :body

  # before_save :body_to_html

  has_many :comments

  validates_presence_of :title, :body
  validates_length_of :title, maximum: 256

  private

  def body_to_html
    # Redcarpet.handle(article.body)
  end
end
