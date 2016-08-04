  class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    User.find_by_session_token(session[:session_token])
    # session = Session.find_by_token(session[:session_token])
    # User.find_by_id(session.user_id)
  end

  def login(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  helper_method :current_user
end
