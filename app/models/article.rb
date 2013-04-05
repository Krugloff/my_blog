require 'redcarpet/krugloff'

class Article < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :title, :body

  has_many :comments
  belongs_to :user

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user_id,
    presence: true

  may_be_as_html :body
end
