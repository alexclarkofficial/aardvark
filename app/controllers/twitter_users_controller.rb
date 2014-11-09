class TwitterUsersController < ApplicationController
  respond_to :json

  def show
    @user = TwitterUser.where(handle: params[:user_name]).first
    if @user.nil?
      twitter_call
      @artists = possible_artists(twitter_mentions).select do |name|
        is_artist?(name)
      end
      @user = TwitterUser.new(name: @name, handle: @screen_name, image_url: @image_url)
      @user.save
      @artists.each do |artist|
        @user.songs.create(rdio_id: artist.foreign_ids[0].foreign_id)
      end
    end
    @user.request_count += 1
    @user.save
    respond_with @user
  end

  def index
    @users = TwitterUser.take(20)
    respond_with @users
  end

  def test
    twitter_call
    @data = @tweets.first
  end
end
