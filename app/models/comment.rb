class Comment < ActiveRecord::Base
  attr_accessible :title, :body

  # before_save :body_to_html

  belongs_to :article
  belongs_to :user

  validates :body, :article, :user,
    presence: true
  
  validates :title,
    length: { maximum: 256 }

  private

  # TODO
  # def body_to_html
  #   Redcarpet.handle body
  # end
end
