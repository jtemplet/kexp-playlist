require 'uri'
require 'net/http'
require 'json'
require 'date'
require 'time'

module Kexp
  module Playlist
    class Fetch
      PAGE_SIZE = 250

      def initialize(start_time, end_time = nil)
        # DateTime keeps these as plain wall-clock times; the API reads them as Pacific time
        @start_time = DateTime.parse(start_time)
        @end_time = end_time ? DateTime.parse(end_time) : @start_time + 1
      end

      def call
        results = []
        uri = build_query
        while uri
          page = fetch_page(uri)
          results.concat(extract_results(page))
          uri = next_uri(page)
        end
        results
      end

      private

      def fetch_page(uri)
        res = Net::HTTP.get_response(uri)
        validate_response(res)
        JSON.parse(res.body)
      end

      def next_uri(page)
        # The API sends a "next" link even on the last page, so a short page is the only end signal
        return if page["results"].size < PAGE_SIZE

        URI(page["next"])
      end

      def build_query
        uri = URI('https://api.kexp.org/v2/plays/')
        uri.query = URI.encode_www_form(query_params)
        uri
      end

      def query_params
        {
          limit: PAGE_SIZE,
          ordering: "-airdate",
          airdate_after: format_time(@start_time),
          airdate_before: format_time(@end_time)
        }
      end

      def format_time(time)
        time.strftime('%Y-%m-%dT%H:%M')
      end

      def time_to_utc(timestamp)
        timestamp.to_s
      end

      def validate_response(res)
        if !res.is_a?(Net::HTTPSuccess)
          puts "Error fetching from KEXP"
          puts "#{res.code} #{res.message}"
          exit(1)
        end
      end

      def extract_results(page)
        page["results"].map do |item|
          next if item["artist"].nil?
          {
            artist: item["artist"],
            song: item["song"],
            airdate: DateTime.parse(item["airdate"])
          }
        end.compact
      end
    end
  end
end
