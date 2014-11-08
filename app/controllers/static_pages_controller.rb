class StaticPagesController < ApplicationController

  def home
    echowrap
    @search_results = Echowrap.song_search(artist: 'Daft Punk')
  end

end
