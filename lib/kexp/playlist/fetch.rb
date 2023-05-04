require 'uri'
require 'net/http'
require 'json'
require 'date'
require 'time'

module Kexp
  module Playlist
    class Fetch
      def initialize(start_time)
        @start_time = Time.parse(start_time) + 1*60*60
      end
    
      def call
        execute_request
        validate_response
          
        extract_results
      end
    
      private
    
      def execute_request
        @res = Net::HTTP.get_response(build_query)
      end  

      def build_query
        uri = URI('https://api.kexp.org/v2/plays/')
        uri.query = URI.encode_www_form(query_params)
        uri
      end

      def query_params
        {
          limit: 250,
          ordering: "-airdate",
          airdate_after: @start_time.strftime('%Y-%m-%dT%H:%M'),
          offset: 0
        }
      end

      def time_to_utc(timestamp)
        timestamp.to_s
      end

      def validate_response
        if !@res.is_a?(Net::HTTPSuccess)
          puts "Error fetching from KEXP"
          puts res
          exit(1)
        end
      end  

      def extract_results
        payload["results"].map do |item|
          next if item["artist"].nil?
          {
            artist: item["artist"],
            song: item["song"],
            airdate: DateTime.parse(item["airdate"])
          }
        end.compact
      end
    
      def payload
        @payload ||= JSON.parse(@res.body)
      end      
    end
  end
end
