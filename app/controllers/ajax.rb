#encoding: utf-8

module Ajax
  include Blinks

  def respond_to_xhr_with_change_history(*template)
    with = yield if block_given?
    respond_to_xhr(*template, {html: '.content'}) do
      change_history + with.to_s
    end
  end

  def add_new_comment
    respond_to_xhr(@comment, before: '.new_comment') do
      change_comments_count + delete_old_alerts
    end
  end

  def change_comments_count
    "$('#comments_count').html('#{@article.comments.count}');"
  end

  def delete_old_alerts
    "$('div.alert').remove();"
  end

  def add_alerts
    respond_to_xhr( { partial: 'layouts/alert',
                      collection: @comment.errors.full_messages },
                    before: '.new_comment' )
  end
end