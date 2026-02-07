RSpec.describe FoobaraDemo::Blog::DeleteArticle do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { article: }
  end
  let(:article) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:, title: "My first article!")
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(blog_slug: "fumiko", full_name: "Fumiko")
  end

  context "when published" do
    before do
      FoobaraDemo::Blog::EditArticle.run!(article:, body: "old body", title: "old title")
      FoobaraDemo::Blog::PublishArticle.run!(article:)
      FoobaraDemo::Blog::EditArticle.run!(article:, body: "new body", title: "new title")
    end

    it "deletes the article and its versions" do
      FoobaraDemo::Blog::Article.transaction do
        expect(FoobaraDemo::Blog::Article.count).to eq(1)
        expect(FoobaraDemo::Blog::ArticleVersion.count).to eq(2)
      end

      expect(outcome).to be_success

      FoobaraDemo::Blog::Article.transaction do
        expect(FoobaraDemo::Blog::Article.count).to eq(0)
        expect(FoobaraDemo::Blog::ArticleVersion.count).to eq(0)
      end

      outcome = FoobaraDemo::Blog::FindArticle.run(article:)

      expect(outcome).to_not be_success
      expect(outcome.errors_hash.keys).to include("data.article.not_found")
    end
  end
end
