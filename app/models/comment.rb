class Comment < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :body

  belongs_to :article
  belongs_to :user

  may_be_as_html :body

  validates :body, :article, :user,
    presence: true
end
