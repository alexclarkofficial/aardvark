class StaticPagesController < ApplicationController

  def home
    echowrap
    @search_results = Echowrap.song_search(artist: 'Daft Punk')

    @result = twitter.user_timeline('vincestaples')
  end


end
