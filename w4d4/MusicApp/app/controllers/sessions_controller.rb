class SessionsController < ApplicationController
  skip_before_action :require_login
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email],
                                      params[:user][:password])
    if @user
      login(@user)
      redirect_to user_url(@user.id)
    else
      redirect_to :new_session, notice: 'invalid login credentials!'
    end
  end

  def destroy
    @user = current_user
    logout(@user)
    redirect_to new_session_url
  end
end
