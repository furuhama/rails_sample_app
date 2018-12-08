class UsersController < ApplicationController
  before_action :logged_in_user, only: %i(index edit update destroy following followers)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy
  before_action :set_user, only: %i(show edit update destroy following followers)
  before_action :set_user_permissions, only: %i(show)

  def index
    @users = User.activated.paginate(page: params[:page])

    respond_to do |format|
      format.html
      format.json { render json: User.activated }
    end
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])

    redirect_to root_url and return unless @user.activated?
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.send_activation_email

      redirect_to root_url, alert: 'Please check your email to activate your account.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, alert: 'Profile updated'
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy

    redirect_to users_url, alert: 'User deleted'
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])

    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page])

    render 'show_follow'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_user_permissions
    @user_permissions = @user.user_permissions.pluck(:name)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # 正しいユーザーか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
