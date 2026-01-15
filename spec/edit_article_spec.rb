RSpec.describe FoobaraDemo::Blog::EditArticle do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    {
      article:,
      body:,
      title:
    }
  end
  let(:article) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:)
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(
      blog_slug: "fumiko",
      full_name: "Fumiko"
    )
  end
  let(:body) { nil }
  let(:title) { nil }

  context "with nil body and title" do
    it "is gives an error" do
      expect(outcome).to_not be_success
      expect(outcome.errors_hash.keys).to include("runtime.neither_title_nor_body_provided")
    end
  end

  context "when not published" do
    context "when changing the body" do
      let(:body) { "new body" }

      it "is successful" do
        expect {
          expect(outcome).to be_success
        }.to change {
               FoobaraDemo::Blog::FindArticle.run!(article:).body
             }.from("").to("new body")
      end
    end

    context "when changing the title" do
      let(:title) { "new title" }

      it "is successful" do
        expect {
          expect(outcome).to be_success
        }.to change {
               FoobaraDemo::Blog::FindArticle.run!(article:).title
             }.from("").to("new title")
      end
    end

    context "when not changing anything" do
      let(:body) { "old body" }
      let(:title) { "old title" }

      before do
        described_class.run!(article:, body:, title:)
      end

      it "is gives an error" do
        expect(outcome).to_not be_success
        expect(outcome.errors_hash.keys).to include("runtime.unchanged")
      end
    end
  end

  context "when published" do
    before do
      described_class.run!(article:, body: "old body", title: "old title")
      FoobaraDemo::Blog::PublishArticle.run!(article:)
    end

    context "when changing the body and title" do
      let(:body) { "new body" }
      let(:title) { "new title" }

      it "edits the article's draft" do
        expect(outcome).to be_success

        updated_article = FoobaraDemo::Blog::FindArticle.run!(article:)

        expect(updated_article.body).to eq("old body")
        expect(updated_article.title).to eq("old title")
        expect(updated_article).to be_published

        draft = updated_article.current_draft

        expect(draft.body).to eq("new body")
        expect(draft.title).to eq("new title")
      end
    end
  end
end
