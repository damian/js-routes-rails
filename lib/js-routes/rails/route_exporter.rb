module Js
  module Routes
    module Rails
      class RouteExporter
        attr_reader :routes

        def initialize(finder = nil)
          @routes = finder.routes
        end

        def export!
          File.open(configuration.output, 'w') do |f|
            f.write(compiled)
          end
        end

        private

        def compiled
          b = binding
          b.local_variable_set(:routes, routes)
          ERB.new(template).result(b)
        end

        def template
          File.read(template_path)
        end

        def template_path
          File.join(template_root, "#{configuration.template}.js")
        end

        def template_root
          File.join(Js::Routes.root, 'templates')
        end

        def configuration
          @configuration ||= Js::Routes::Rails.configuration
        end
      end
    end
  end
end
