require 'redcarpet/krugloff'

class Article < ActiveRecord::Base
  attr_accessible :title, :body

  has_many :comments
  belongs_to :user

  after_save :clear_body_cache, if: '@html'

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user,
    presence: true

  def body_as_html
    return @html if @html
    syntax = Redcarpet::Render::Krugloff.new filter_html: true
    parser = Redcarpet::Markdown.new syntax,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true
    @html = parser.render(body).html_safe
  end

  private

    def clear_body_cache
      @html = nil
    end
end
