class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def echowrap
    Echowrap.configure do |config|
      config.api_key =       ENV['ECHONEST_API_KEY']
      config.consumer_key =  ENV['ECHONEST_CONSUMER_KEY']
      config.shared_secret = ENV['ECHONEST_SHARED_SECRET']
    end

  end

  def twitter
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

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
    mentions.uniq
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
