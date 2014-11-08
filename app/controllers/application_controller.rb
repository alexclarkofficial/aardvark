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
end
