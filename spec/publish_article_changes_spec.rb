RSpec.describe FoobaraDemo::Blog::PublishArticleChanges do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { article: }
  end
  let(:article) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:, title:)
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(blog_slug: "fumiko", full_name: "Fumiko")
  end
  let(:title) { "My First Post" }

  context "when published" do
    before do
      FoobaraDemo::Blog::EditArticle.run!(article:, body: "old body", title: "old title")
      FoobaraDemo::Blog::PublishArticle.run!(article:)
    end

    context "when changing the body and title" do
      context "when loading as an aggregate" do
        it "edits the article's draft" do
          FoobaraDemo::Blog::EditArticle.run!(article:, body: "new body", title: "new title")

          updated_article = FoobaraDemo::Blog::FindArticle.run!(article:)

          expect(updated_article.body).to eq("old body")
          expect(updated_article.title).to eq("old title")
          expect(updated_article).to be_published

          draft = updated_article.current_draft

          expect(draft.body).to eq("new body")
          expect(draft.title).to eq("new title")

          expect(outcome).to be_success

          updated_article = FoobaraDemo::Blog::FindArticle.run!(article:)

          expect(updated_article.body).to eq("new body")
          expect(updated_article.title).to eq("new title")

          updated_article = FoobaraDemo::Blog::FindArticle.run!(article:, aggregate: true)

          expect(updated_article.past_published_versions.first.body).to eq("old body")
        end
      end

      context "when loading using load_paths:" do
        it "edits the article's draft" do
          FoobaraDemo::Blog::EditArticle.run!(article:, body: "new body", title: "new title")

          expect(outcome).to be_success

          updated_article = FoobaraDemo::Blog::FindArticle.run!(
            article:,
            load_paths: [[:past_published_versions, :"#"]]
          )

          expect(updated_article.past_published_versions.first.body).to eq("old body")
        end
      end
    end
  end
end
