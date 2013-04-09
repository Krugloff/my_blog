require 'redcarpet'
require 'coderay'

module MarkdownAsHtml
  def self.included(base)
    base.after_save :clear_body_cache, if: '@html'

    base.cattr_accessor(:markdown_render) do
      Redcarpet::Render::Article.new  filter_html: true,
                                      no_images: true,
                                      safe_links_only: true
    end

    def base.may_be_as_html(*attr_name)
      attr_name.each do |name| define_method "#{name}_as_html" do
        return @html if @html
        parser = Redcarpet::Markdown.new  markdown_render,
                                          no_intra_emphasis: true,
                                          fenced_code_blocks: true,
                                          lax_spacing: true,
                                          strikethrough: true
        @html = parser.render(self.send name).html_safe
      end end
    end
  end

  private

    def clear_body_cache
      @html = nil
    end
end

module Redcarpet::Render
  class Article < HTML
    def block_code( code, language )
      $VERBOSE, verbose = nil, $VERBOSE
      CodeRay.scan( code, language || :text ).div

      rescue ArgumentError; CodeRay.scan( code, :text ).div
      ensure $VERBOSE = verbose
    end

    def header(text, level)
      case level
      when 3
        "<h3>#{text}</h3>"
      when 4
        "<h4>#{text}</h4>"
      when 5
        "<h5>#{text}</h5>"
      when 6
        "<h6>#{text}</h6>"
      else
        header text, 3
      end
    end
  end

  class Comment < Article
    def header(text, level)
      super text, 5
    end
  end
end