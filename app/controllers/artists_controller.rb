class ArtistsController < ApplicationController
    def index
        artists = Artist.all
        render json: ArtistSerializer.new(artists)
      end

    def show
        artist = Artist.find(params[:id])
        render json: ArtistSerializer.new(artist)
      end

      def create
        artist = Artist.create(artist_params)
        if artist.valid?
            # payload = { artist_id: artist.id }

            # token = JWT.encode payload, 'fortytwo', 'HS256'
            
            # render json: {token: token}
            render json: { token: encode_token(artist_payload(artist)) }
        else
            render json: {errors: artist.errors.full_messages}
        end

    end

    def profile
        render json: current_artist
    end

    private

    def artist_params
        params.permit(:name, :email, :password, :avatar)
    end
end