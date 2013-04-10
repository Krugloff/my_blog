require 'redcarpet/markdown_as_html'

class Comment < ActiveRecord::Base
  include MarkdownAsHtml

  attr_accessible :body, :parent_id

  before_destroy do
    unless ( children = self.child_ids ).empty?
      Comment.update_all( { parent_id: self.parent_id }, id: children )
    end
  end

  belongs_to :article
  belongs_to :user

  with_options class_name: 'Comment', foreign_key: 'parent_id' do |comment|
    comment.has_many :children
    comment.belongs_to :parent
  end

  validates :body, :article_id, :user_id,
    presence: true

  options = { filter_html: true, no_images: true, safe_links_only: true }
  self.markdown_render = Redcarpet::Render::Comment.new options
  may_be_as_html :body
end
