class Api::V1::UsersController < ApplicationController
  def index
    @users = User.all

    # params に :id パラメータが渡されていた場合はactiverecord_relationを更新
    if user_params[:id].present?
      @users = User.where(id: user_params[:id])
    end

    @users = @users.map do |user|
      {
          id: user.id,
          name: user.name,
      }
    end

    render json: @users
  end

  private

  def user_params
    params.permit(:id)
  end
end
