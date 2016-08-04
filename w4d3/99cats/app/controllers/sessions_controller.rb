class SessionsController < ApplicationController
  before_action :not_logged_in, only:[:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username],
                                     params[:user][:password])
    if @user
      login(@user)
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to cats_url
  end

  private

  def not_logged_in
    redirect_to cats_url if current_user
  end
end
