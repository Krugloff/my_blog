module Ajax
  include Blinks

  def respond_to_xhr_for_nav
    with = yield if block_given?
    respond_to_xhr(html: '.content') { reload_nav + change_title + with.to_s }
  end

  def reload_nav
    return "" unless @article.try(:persisted?)
    render_file( { partial: 'layouts/nav' }, replaceWith: 'nav' ) if @article
  end

  def change_title
    %| $('head > title').html('#{@title}'); |
  end

  def render_comment
    render @comment, layout: false
  end

  def render_alerts
    html = render_to_string partial: 'layouts/alert',
                            collection: @comment.errors.full_messages
    render text: html, status: 406
  end
end