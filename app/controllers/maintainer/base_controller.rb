module Maintainer
  class BaseController < ApplicationController
    before_action :authenticate_maintainer

    private

    def is_maintainer?
      current_user.user_permissions.name_list.include?('maintainer')
    end

    def authenticate_maintainer
      unless is_maintainer?
        redirect_to root_path, alert: 'ピピーッ!!あんたmaintainerじゃないやん!!!!!!!!!!!!!!!!!!'
      end
    end
  end
end