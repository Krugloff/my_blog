module AccountsHelper
  def github_badge
    link_to image_tag('github.png'), '/session/new/github', title: 'GitHub'
  end

  def developer_badge
    link_to image_tag('developer.png'), '/session/new/developer',
      title: 'Developer'
  end

  def badges
    concat github_badge
    developer_badge if Rails.env.development?
  end
end
