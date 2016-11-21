require "js-routes/rails/engine"
require "js-routes/rails/version"

module Js
  module Routes
    module Rails
      class << self
        attr_writer :configuration
      end

      def self.configuration
        @configuration ||= OpenStruct.new
      end

      def self.export!(routes = nil)
        finder = Js::Routes::Rails::RouteFinder.new(routes)
        exporter = Js::Routes::Rails::RouteExporter.new(finder)
        exporter.export!
      end

      def self.configure
        yield configuration
      end
    end
  end
end
