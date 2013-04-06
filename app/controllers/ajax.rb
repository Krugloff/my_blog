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

  def add_new_comment
    target =
      if nested?
        parent_id = params[:comment][:parent_id]
        selector = ".comment_tree:has( div#comment_#{parent_id} )"
        { 'last().append' => selector }
      else
        { before: '#new_comment' }
      end

    respond_to_xhr(@comment, target)
  end

  def nested?
    !params[:comment][:parent_id].blank?
  end

  def add_alerts
    html = render_to_string partial: 'layouts/alert',
                            collection: @comment.errors.full_messages
    render text: html, status: 406
  end
end