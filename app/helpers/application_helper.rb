module ApplicationHelper
  def logout_link
    link_to glyphicon('icon-off'), session_path,
      method: 'delete', class: 'pull-right'
  end

  def registration_link
    link_to glyphicon('icon-plus-sign'), new_user_path, class: 'pull-right'
  end

  def glyphicon(name)
    content_tag( 'i', nil, class: name )
  end

  def tab( content, path )
    content_tag 'li', link_to( content, path ), class: _active?(path)
  end

  private

    def _active?(path)
      current_page?(path) ? 'active' : ''
    end
end
