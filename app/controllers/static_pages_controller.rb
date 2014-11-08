class StaticPagesController < ApplicationController

  def home
    echowrap
    @search_results = Echowrap.song_search(artist: 'Daft Punk')

    @result = twitter.user_timeline('vincestaples', { exclude_replies: true, count: 200 })
  end


  def user
    @mentions = []
    twitter.user_timeline(params[:id], { exclude_replies: true, count: 200 }).each do |tweet|
      tweet.user_mentions.each do |mention|
        @mentions << mention.attrs[:screen_name]
      end
    end
  end

end
