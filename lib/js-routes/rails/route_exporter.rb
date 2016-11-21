module Js
  module Routes
    module Rails
      class RouteExporter
        attr_reader :routes

        def initialize(finder = nil)
          @routes = finder.routes
        end

        def export!
          File.open(output_path, 'w') { |f| f.write(compiled) }
        end

        private

        def output_path
          ::Rails.root.join('app', 'assets', 'javascripts', 'js-routes-rails.js')
        end

        def compiled
          b = binding
          b.local_variable_set(:routes, routes)
          ERB.new(template).result(b)
        end

        def template
          File.read(template_path)
        end

        def template_path
          File.join(Js::Routes.root, 'js-routes-rails-template.js')
        end
      end
    end
  end
end
