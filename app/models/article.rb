require 'redcarpet/krugloff'

class Article < ActiveRecord::Base
  attr_accessible :title, :body

  before_save :body_to_html

  has_many :comments
  belongs_to :user

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user,
    presence: true

  private

  def body_to_html
    syntax = Redcarpet::Render::Krugloff.new filter_html: true
    parser = Redcarpet::Markdown.new syntax,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true
    self.body = parser.render(body)
  end
end
