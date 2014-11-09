class TwitterUsersController < ApplicationController
  respond_to :json

  def show
    @user = TwitterUser.find(params[:id])

    respond_with @user
  end
end
