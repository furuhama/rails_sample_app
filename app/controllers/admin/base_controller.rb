module Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin

    private

    def is_admin?
      current_user.user_permissions.name_list.include?('admin')
    end

    def authenticate_admin
      unless is_admin?
        redirect_to root_path, alert: 'ピピーッ!!あんたadminじゃないやん!!!!!!!!!!!!!!!!!!'
      end
    end
  end
end