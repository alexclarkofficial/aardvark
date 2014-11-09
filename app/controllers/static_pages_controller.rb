class StaticPagesController < ApplicationController
  before_action :echowrap
  respond_to :json

  def home
    @search_results = Echowrap.song_search(artist: 'Daft Punk')
  end


  def handle
    @user = TwitterUser.where(handle: params[:user_name])
    if @user.empty?
      @user = TwitterUser.new(handle: params[:user_name], name: params[:user_name])
      names = twitter_mentions(params[:user_name]).uniq
      @artists = possible_artists(names).select do |name|
        is_artist?(name)
      end
    else
      @artists = @user.songs
    end

    respond_with @artists
  end

  private

  def twitter_mentions(user)
    mentions = []
    twitter.user_timeline(user, { exclude_replies: true, count: 200 }).each do |tweet|
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
