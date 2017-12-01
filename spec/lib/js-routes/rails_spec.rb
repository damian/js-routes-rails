describe Js::Routes::Rails do
  describe ".class methods" do
    describe ".configuration object" do
      it "should default the output path" do
        expect(described_class.configuration.output).to eq("app/assets/javascripts/js-routes-rails.js")
      end

      it "should default the output template" do
        described_class.configuration = nil
        expect(described_class.configuration.template).to eq(:rails)
      end
    end

    it "allow us to override the default configuration object" do
      described_class.configure do |config|
        config.template = :commonjs
      end

      expect(described_class.configuration.template).to eq(:commonjs)
    end

    describe "export!" do
      let(:routes) { ::Rails.application.routes.routes }
      it "should export the routes" do
        finder = double(routes: {
          "post_comments_path" => "/posts/:post_id/comments",
          "new_post_comment_path" => "/posts/:post_id/comments/new",
          "edit_post_comment_path" => "/posts/:post_id/comments/:id/edit",
          "post_comment_path"=>"/posts/:post_id/comments/:id"
        })

        dbl = double
        allow(dbl).to receive(:routes)
        allow(dbl).to receive(:export!)

        allow(Js::Routes::Rails::RouteFinder).to receive(:new).with(routes) { finder }
        allow(Js::Routes::Rails::RouteExporter).to receive(:new).with(finder) { dbl }
        described_class.export!(routes)
      end
    end
  end
end
