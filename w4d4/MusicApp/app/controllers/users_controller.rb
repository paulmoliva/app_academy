class UsersController < ApplicationController

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      redirect_to new_user_url, notice: self.errors.full_messages
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  private

  def user_params
    params.require(:user).permit([:email, :password])
  end

end
