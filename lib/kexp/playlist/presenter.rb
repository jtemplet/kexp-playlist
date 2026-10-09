
module Kexp
  module Playlist
    class Presenter
      # The API's airdate carries the Pacific offset in effect when the song played
      PACIFIC_ZONES = { "-07:00" => "PDT", "-08:00" => "PST" }.freeze
      COLUMN_GAP = "  ".freeze

      def initialize(songs, display_timestamp)
        @results = songs
        @display_timestamp = display_timestamp
      end
      
      def call
        print_results
      end

      private 

      def zone_label(airdate)
        offset = airdate.strftime("%:z")
        PACIFIC_ZONES.fetch(offset, "UTC" + offset)
      end

      def print_results
        rows = @results.sort_by { |result| result[:airdate] }.map { |result| [timestamp(result[:airdate]), result[:artist], result[:song]] }
        widths = rows.transpose.map { |column| column.map(&:length).max }
        rows.each do |time, artist, song|
          puts [time.ljust(widths[0]), artist.ljust(widths[1]), song].join(COLUMN_GAP)
        end
      end

      def timestamp(airdate)
        airdate.strftime("%Y-%m-%d %I:%M %p") + " " + zone_label(airdate)
      end
    end
  end
end        