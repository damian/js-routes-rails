describe Js::Routes::Rails::RouteFinder do
  let(:routes) { Rails.application.routes.routes }
  subject { described_class.new(routes) }

  it "should find all the exported routes on initialize" do
    expect(subject.routes).to be_a(Hash)
    expect(subject.routes["post_comments_path"]).to eq("/posts/:post_id/comments")
    expect(subject.routes["new_post_comment_path"]).to eq("/posts/:post_id/comments/new")
    expect(subject.routes["edit_post_comment_path"]).to eq("/posts/:post_id/comments/:id/edit")
    expect(subject.routes["post_comment_path"]).to eq("/posts/:post_id/comments/:id")
  end
end
