class UsersController < ApplicationController
  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = self.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end
end
