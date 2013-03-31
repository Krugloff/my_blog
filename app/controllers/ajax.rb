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

  def add_tooltip
    %| $('a.preview').tooltip( {animation: false} ) |
  end

  #? В данном случае нельзя обновлять всю панель навигации, потому что метод .current_page? работает только для GET запросов.
  def add_new_comment
    respond_to_xhr(@comment, before: '#new_comment') do
      change_comments_count + delete_old_alerts
    end
  end

  def nested?
    !params[:comment][:parent_id].empty?
  end

  def change_comments_count
    %| $('#comments_count').html('#{@article.comments.count}'); |
  end

  def delete_old_alerts
    %| $('div.alert').remove(); |
  end

  def add_alerts
    selector = nested? ? '#nested_new_comment' : '#new_comment'
    respond_to_xhr( { partial: 'layouts/alert',
                      collection: @comment.errors.full_messages },
                    before: selector )
  end

  def delete_comment_view
    %| $('#comment_#{@comment.id}').parent().remove(); |
  end
end