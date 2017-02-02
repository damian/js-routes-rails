describe Js::Routes::Rails::RouteExporter do
  let(:routes) { Rails.application.routes.routes }
  let(:finder) { Js::Routes::Rails::RouteFinder.new(routes) }
  subject { described_class.new(finder) }

  it "should store a reference to the exportable routes" do
    expect(subject.routes).to eq(finder.routes)
  end

  it "should generate a JavaScript file lib containing the routes and output it on disk" do
    allow(File).to receive(:open).with(/.*app\/assets\/javascripts\/js-routes-rails.js/, "w")
    subject.export!
  end
end
