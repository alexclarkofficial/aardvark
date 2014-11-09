class SongsController < ApplicationController
    respond_to :json

    def show
        @song = Song.first()

        respond_with @song
    end
end