#encoding: utf-8

require 'omniauth'
require 'omniauth-github'

Rails.application.config.middleware.use OmniAuth::Builder do

  unless Rails.env.production?
    provider  :developer,
              uid_field: 'uid',
              fields: %w(name uid),
              callback_path: '/session/developer/new'
  end

  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'],
    callback_path: '/session/github/new'
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.path_prefix = '/session/new'