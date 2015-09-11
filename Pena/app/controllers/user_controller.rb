class UserController < ApplicationController
  before_action

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    current_user.follow(@event)
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@event)
      respond_to do |format|
        format.js{}
      end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to @user
  end


  private

  def user_params
    params.require(:user).permit(:lat, :lon, :access_token, :name, :image_url, :email, :headline, :industry, :company, :title)
  end

end
