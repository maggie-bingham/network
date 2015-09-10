class UserController < ApplicationController

  def index
    @user= current_user
    @user.update(user_params)
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def follow
    @user = User.find(params[:id])
    if @user.cannot_follow?(@user)
      respond_to do |format|
        format.html {redirect_to :back, :notice => "You can't follow this user."}
      end
    else
      current_user.follow(@user)
      respond_to do |format|
        format.js {}
      end
    end
  end

  def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
      respond_to do |format|
        format.js{}
      end
  end

  private

  def user_params
    params.require(:users).permit(:lat, :lon, :access_token, :name, :image_url, :email, :headline, :industry, :company, :title)
  end

end
