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



end
