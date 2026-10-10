require 'json'

module Kexp
  module Playlist
    class JsonPresenter
      def initialize(songs)
        @songs = songs
      end

      def call
        puts JSON.pretty_generate(plays)
      end

      private

      def plays
        @songs.sort_by { |song| song[:airdate] }.map do |song|
          {
            airdate: song[:airdate].iso8601,
            artist: song[:artist],
            song: song[:song],
            album: song[:album]
          }
        end
      end
    end
  end
end
