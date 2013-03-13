#encoding: utf-8

require 'omniauth'
require 'omniauth-github'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.path_prefix = '/session/new'