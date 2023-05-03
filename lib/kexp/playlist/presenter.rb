
module Kexp
  module Playlist
    class Presenter
      def initialize(songs, display_timestamp)
        @results = songs
        @display_timestamp = display_timestamp
      end
      
      def call
        print_results
      end

      private 

      def print_results
        @results.reverse.each do |result|
          print result[:artist] + " - " + result[:song]
          if (@display_timestamp)
            print "  [" + result[:airdate].strftime("%m/%d/%Y %I:%M %p") + " PDT]"
          end
          print "\n"
        end
        p @start_time.to_s
      end
    end
  end
end        