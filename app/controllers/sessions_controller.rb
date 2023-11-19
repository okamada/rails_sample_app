class SessionsController < ApplicationController
  def new
  end

  def create
    @admin = User.find_by(email: params[:session][:email].downcase)
    if @admin&.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session # ログインの直前に必ず書く処理 ∵セッション固定攻撃への対策
      params[:session][:remember_me] == '1' ? remember(@admin) : forget(@admin)
      log_in @admin
      redirect_to forwarding_url || @admin
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    flash.now[:info] = 'You successfuly logged out'
    redirect_to root_url, status: :see_other
  end
end
