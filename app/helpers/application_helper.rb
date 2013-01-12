module ApplicationHelper
  def tab( content, path )
    content_tag 'li', link_to( content, path ), class: _active?(path)
  end

  def glyphicon(name)
    content_tag( 'i', nil, class: name )
  end

  private

    def _active?(path)
      current_page?(path) ? 'active' : ''
    end
end
