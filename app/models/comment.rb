require 'redcarpet/krugloff'

class Comment < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :body, :parent_id

  belongs_to :article
  belongs_to :user

  with_options class_name: 'Comment', foreign_key: 'parent_id' do |comment|
    comment.has_many :children
    comment.belongs_to :parent
  end

  may_be_as_html :body

  validates :body, :article, :user,
    presence: true
end
