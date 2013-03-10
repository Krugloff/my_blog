#encoding: utf-8

module Ajax
  include Blinks

  def respond_to_xhr_with_change_history(*template)
    with = yield if block_given?
    respond_to_xhr(*template, {html: '.blinks'}) do
      change_history + with.to_s
    end
  end
end