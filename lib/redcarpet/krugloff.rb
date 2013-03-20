#encoding: utf-8
require 'redcarpet'
require 'coderay'

module Redcarpet::Render class Krugloff < HTML
  def block_code( code, language )
    CodeRay.scan( code, language || :text ).div
  end
end end

module MarkdownAsHtml
  def self.included(base)
    base.after_save :clear_body_cache, if: '@html'

    def base.may_be_as_html(*attr_name)
      attr_name.each do |name|
        define_method "#{name}_as_html" do
          return @html if @html
          syntax = Redcarpet::Render::Krugloff.new filter_html: true
          parser = Redcarpet::Markdown.new syntax,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            lax_spacing: true
          @html = parser.render(self.send name).html_safe
        end
      end
    end
  end

  private

    def clear_body_cache
      @html = nil
    end
end