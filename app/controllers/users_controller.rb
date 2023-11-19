class UsersController < ApplicationController

  before_action :logged_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [        :edit, :update]
  before_action :admin_user,      only: [                        :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @admin = User.find(params[:id])
  end
  
  def new
    @admin = User.new
  end

  def create
    @admin = User.new(user_params)

    if @admin.save
      reset_session # やらなくても良い気がする；log_inでやってるし
      log_in @admin
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @admin
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @admin.update(user_params)
      # TODO 更新に成功した場合の処理
      flash[:success] = "Profile updated"
      redirect_to @admin
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url, status: :see_other
  end

  private
    # beforeフィルタ start

    # ログイン済ユーザーか？
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url, status: :see_other
      end
    end

    # 正しいユーザーか？
    def correct_user
      @admin = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@admin)
    end

    # 管理者か？
    def admin_user
      redirect_to(root_url, status: :see_other) unless current_user.admin?
    end

    # beforeフィルタ end

    def user_params
      params
        .require(:user)
        .permit(
          :name,
          :email,
          :password,
          :password_confirmation
        )
    end
end
