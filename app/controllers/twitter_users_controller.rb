class TwitterUsersController < ApplicationController
  respond_to :json

  def show
    @user = TwitterUser.find(:first, :conditions => ["lower(handle) = ?", params[:user_name].downcase])
    if @user.nil?
      twitter_call(params[:user_name])
      @artists = possible_artists(twitter_mentions).select do |name|
        is_artist?(name[:artist])
      end
      @user = TwitterUser.new(name: @name, handle: @screen_name, image_url: @image_url)
      @user.save
      @artists.each do |artist|
        @user.songs.create(rdio_id: artist[:artist].foreign_ids[0].foreign_id, referer_handle: artist[:handle])
      end
      friends = twitter.friends(params[:user_name])
      friends.take(10).each do |friend|
        @user.friends.create(name: friend.name, handle: friend.screen_name, image_url: friend.profile_image_url.to_s)
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
    twitter_call('vincestaples')
    @data = twitter.friends('earlxsweat')
  end
end
