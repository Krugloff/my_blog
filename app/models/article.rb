require 'redcarpet/krugloff'

class Article < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :title, :body

  has_many :comments
  belongs_to :user

  may_be_as_html :body

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user,
    presence: true
end
