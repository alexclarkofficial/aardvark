class StaticPagesController < ApplicationController
  before_action :echowrap

  def home
    @data = twitter.user_timeline('alexanderhclark', { exclude_replies: true, count: 200 })
  end

  def handle
    @user = TwitterUser.where(handle: params[:user_name])
    if @user.empty?
      twitter_call
      @artists = possible_artists(twitter_mentions).select do |name|
        is_artist?(name)
      end
      @user = TwitterUser.new(name: @name, handle: @screen_name, image_url: @image_url)
      @user.save
    end
  end

  private

  def twitter_call
    @tweets = twitter.user_timeline(params[:user_name], { exclude_replies: true, count: 200 })
    @name = @tweets.first.user.name
    @screen_name = @tweets.first.user.screen_name
    @image_url = @tweets.first.user.profile_image_url.to_s
  end

  def twitter_mentions
    mentions = []
    @tweets.each do |tweet|
      tweet.user_mentions.each do |mention|
        mentions << mention.attrs[:name]
      end
    end
    mentions
  end

  def possible_artists(names)
    names[0..19].map do |artist|
      Echowrap.artist_search(name: artist, bucket: 'id:rdio-US').first
    end.compact
  end

  def is_artist?(name)
    !name.foreign_ids.empty?
  end
end
