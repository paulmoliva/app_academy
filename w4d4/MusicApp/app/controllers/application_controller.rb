class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login
  def login(user)
    user.reset_session_token
    session[:session_token] = user.session_token
  end

  def logout(user)
    user.reset_session_token
    session[:session_token] = nil
  end

  def current_user
    User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def require_login
    unless logged_in?
      redirect_to new_session_url, notice: 'You must log in to do that!'
    end
  end

  helper_method :current_user, :logged_in?, :require_login
end
