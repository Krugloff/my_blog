#encoding: utf-8

module Blinks
  include ActionView::Helpers::JavaScriptHelper

  def respond_to_xhr(*template, target)
    if request.xhr?
      # For catch redirecting.
      self.response.headers['X-Blinks-Url'] = request.base_url + request.path
      with = yield if block_given?
      render js: js_function( render_file(*template, target) + with.to_s )
    end
  end

  def render_file(*template, target)
    if template.empty?
      template = [ (controller_name + '/' + action_name), { layout: false } ]
    end
    js_method = target.keys.first.to_s
    selector = target.values.first.to_s

    html = render_to_string(*template)
    %| $('#{selector}').#{js_method}('#{escape_javascript html}'); |
  end

  def js_function(content)
    %| (function(){#{content}})(); |
  end
end