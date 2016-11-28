require 'rails'
require 'js-routes-rails'

module Rails
  class App
    def env_config; {} end
    def routes
      return @routes if defined?(@routes)
      @routes = ActionDispatch::Routing::RouteSet.new
      @routes.draw do
        resources :posts do
          resources :comments, export: true
        end
      end
      @routes
    end
  end

  def self.application
    @app ||= App.new
  end
end
