require 'redcarpet/krugloff'

class Comment < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :body, :parent_id

  belongs_to :article
  belongs_to :user

  with_options class_name: 'Comment', foreign_key: 'parent_id' do |comment|
    comment.has_many :children, :dependent => :nullify
    comment.belongs_to :parent
  end

  validates :body, :article_id, :user_id,
    presence: true

  may_be_as_html :body
end
