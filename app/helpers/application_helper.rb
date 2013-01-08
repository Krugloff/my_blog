module ApplicationHelper
  def tab_for( content, path )
    content_tag 'li', link_to( content, path ), class: _active?(path)
  end

  private

    def _active?(path)
      current_page?(path) ? 'active' : ''
    end
end
