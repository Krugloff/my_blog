ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  self.ingots_path = "#{Rails.root}/test/ingots"

  setup { Rails.logger.debug method_name }

  def login_as(user)
    session[:user_id] = users(user).id
  end
end
