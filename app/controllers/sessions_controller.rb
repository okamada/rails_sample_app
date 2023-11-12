class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session # ログインの直前に必ず書く処理 ∵セッション固定攻撃への対策
      remember user
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out
    flash.now[:info] = 'You successfuly logged out'
    redirect_to root_url, status: :see_other
  end
end
