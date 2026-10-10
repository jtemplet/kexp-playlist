require 'optparse'
require_relative 'kexp/playlist/fetch'
require_relative 'kexp/playlist/presenter'
require_relative 'kexp/playlist/json_presenter'

module Kexp
  module Playlist
    class Query

      def self.call(options)
        results = Kexp::Playlist::Fetch.new(options[:start], options[:end]).call
        presenter(results, options).call
      end

      def self.presenter(results, options)
        case options.fetch(:format, "text")
        when "json" then Kexp::Playlist::JsonPresenter.new(results)
        else Kexp::Playlist::Presenter.new(results, options[:time])
        end
      end
    end
  end
end      