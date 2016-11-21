require "js-routes/rails/route_finder"
require "js-routes/rails/route_exporter"

module Js
  module Routes
    module Rails
      class Engine < ::Rails::Engine
        rake_tasks do
          load "js-routes/tasks/js-routes-rails.rake"
        end
      end
    end
  end
end
