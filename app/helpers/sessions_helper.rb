module SessionsHelper
  def github_badge
    link_to image_tag('github.png'), '/session/new/github', title: 'GitHub'
  end

  def developer_badge
    link_to image_tag('developer.png'), '/session/new/developer',
      title: 'Developer'
  end
end
