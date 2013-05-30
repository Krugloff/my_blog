source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'jquery-rails'
gem 'gravatar_image_tag'

gem 'coderay'
gem 'redcarpet'

gem 'cando', git: 'http://github.com/Krugloff/cando'
gem 'omniauth-github'

gem 'rack-contrib'

group :production do
  gem 'pg'
  gem 'unicorn'
end

group :development, :test do
  gem 'sqlite3'
end

group :test do
  gem 'ruby-prof'
  gem 'smeltery', git: 'http://github.com/Krugloff/smeltery.git'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'bootstrap-sass'
  gem 'coffee-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier'
end