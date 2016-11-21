namespace :js_routes_rails do
  desc "Generates an JavaScript file containing routes accessible on the client"
  task :export => :environment do
    Js::Routes::Rails.export!(::Rails.application.routes.routes)
  end
end
