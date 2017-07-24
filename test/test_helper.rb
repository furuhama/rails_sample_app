ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  fixtures :all
  
  # テストユーザーがログイン中の場合に true を返す
  def is_logged_in?
    !session[:user_id].nil?
  end
end
