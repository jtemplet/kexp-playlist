
module Kexp
  module Playlist
    class Presenter
      # The API's airdate carries the Pacific offset in effect when the song played
      PACIFIC_ZONES = { "-07:00" => "PDT", "-08:00" => "PST" }.freeze

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
        @results.reverse.each do |result|
          print result[:artist] + " - " + result[:song]
          if (@display_timestamp)
            print "  [" + result[:airdate].strftime("%m/%d/%Y %I:%M %p") + " " + zone_label(result[:airdate]) + "]"
          end
          print "\n"
        end
      end
    end
  end
end        