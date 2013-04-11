require 'redcarpet'
require 'coderay'

require 'active_support/core_ext/class/attribute_accessors.rb'
require 'active_support/core_ext/module/attribute_accessors.rb'

module MarkdownAsHtml
  def self.included(model)
    model.after_save :clear_body_cache, if: '@html' if MarkdownAsHtml.memory?


    model.cattr_accessor(:markdown_parser)

    def model.markdown_render=(render)
      @@markdown_render = render
      self.markdown_parser =
        Redcarpet::Markdown.new render, DEFAULT_PARSER_OPTIONS
    end

    model.markdown_render =
      Redcarpet::Render::Article.new(DEFAULT_RENDER_OPTIONS)

    def model.markdown_render
      @@markdown_render
    end

    def model.may_be_as_html(*attr_name)
      if MarkdownAsHtml.db?
        before_save do attr_name.each do |name|
          send "#{name}_as_html=", markdown_parser.render(self.send name)
        end end
      else
        attr_name.each do |name| define_method "#{name}_as_html" do
          @html ||= markdown_parser.render(self.send name).html_safe
        end end
      end
    end
  end

  DEFAULT_RENDER_OPTIONS =
    { filter_html: true, no_images: true, safe_links_only: true }

  DEFAULT_PARSER_OPTIONS =
    { no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true,
      strikethrough: true }

  mattr_accessor :storage
  self.storage = :db

  def self.db?
    self.storage == :db
  end

  def self.memory?
    self.storage == :memory
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