module Js
  module Routes
    module Rails
      class RouteFinder
        attr_reader :routes

        def initialize(application_routes = nil)
          @routes = {}
          @application_routes = application_routes
          find_routes
        end

        def find_routes
          @application_routes.to_a.each do |route|
            if route.defaults.key?(:export) && route.name.present?
              @routes[path_helper(route)] = path(route)
            end
          end
        end

        def path_helper(route)
          "#{route.name}_path"
        end

        def path(route)
          route.path.spec.to_s.chomp("(.:format)")
        end
      end
    end
  end
end
