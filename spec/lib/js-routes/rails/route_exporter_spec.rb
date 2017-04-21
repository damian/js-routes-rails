describe Js::Routes::Rails::RouteExporter do
  let(:routes) { Rails.application.routes.routes }
  let(:finder) { Js::Routes::Rails::RouteFinder.new(routes) }
  subject { described_class.new(finder) }
  let(:fake_output) { StringIO.new }

  before do
    output_path = Js::Routes::Rails.configuration.output
    allow(File).to receive(:open).with(output_path, "w").and_yield(fake_output)
  end

  it "should store a reference to the exportable routes" do
    expect(subject.routes).to eq(finder.routes)
  end

  it "should generate a JavaScript file lib containing the routes and output it on disk" do
    subject.export!

    subject.routes.each do |helper, path|
      expect(fake_output.string).to include(helper)
      expect(fake_output.string).to include(path)
    end
  end

  context "when configured with a custom template file" do
    let(:template_path) { "/foo/bar/template.js" }

    around do |example|
      original = Js::Routes::Rails.configuration.template
      Js::Routes::Rails.configuration.template = template_path
      example.run
      Js::Routes::Rails.configuration.template = original
    end

    it "should render the custom template" do
      fake_template = "Hello world. 1 + 2 = <%= 1 + 2 %>"
      allow(File).to receive(:read).with(template_path).and_return(fake_template)

      subject.export!
      expect(fake_output.string).to eq("Hello world. 1 + 2 = 3")
    end
  end
end
