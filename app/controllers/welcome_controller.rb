class WelcomeController < ApplicationController
  def index
    @user = current_user
    begin
      @user.try(:title)
    rescue Faraday::ClientError
      redirect_to '/auth/linkedin'
    end
  end
end
