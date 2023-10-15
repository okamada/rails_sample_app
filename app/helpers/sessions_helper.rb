module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    reset_session
    @current_user = nil # 安全のため
  end

  # 現在ログイン中のユーザーを返す (nilable)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # ユーザーがログインしている時true, それ以外の時false
  def logged_in?
    !current_user.nil?
  end
end
