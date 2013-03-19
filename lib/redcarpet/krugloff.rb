#encoding: utf-8
require 'redcarpet'
require 'coderay'

module Redcarpet::Render class Krugloff < HTML
  def block_code( code, language )
    CodeRay.scan( code, language || :text ).div
  end
end end