require 'optparse'
require_relative 'kexp/playlist/fetch'
require_relative 'kexp/playlist/presenter'

module Kexp
  module Playlist
    class Query

      def self.call(options)
        results = Kexp::Playlist::Fetch.new(options[:start]).call
        Kexp::Playlist::Presenter.new(results, options[:time]).call
      end  
    end
  end
end      