module ApplicationHelper
  def logout_link
    link_to glyphicon('icon-off'), session_path,
      method: 'delete', class: 'pull-right logout'
  end

  def registration_link
    link_to glyphicon('icon-plus-sign'), new_user_path, class: 'pull-right'
  end

  def glyphicon(name)
    content_tag( 'i', nil, class: name )
  end

  def tab( content, path, is_remote = true )
    link_to content, path, remote: is_remote,
      class: _active?(path)
  end

  def created_at(model)
    model.created_at.getlocal.strftime "%e.%m.%y в %R"
  end

  def use_markdown
    'Используйте Markdown для форматирования текста. Html разметка не сохраняется. Подробности: http://help.github.com/articles/github-flavored-markdown'
  end

  private

    def _active?(path)
      current_page?(path) ? 'active' : ''
    end
end
