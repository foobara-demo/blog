RSpec.describe FoobaraDemo::Blog::PublishArticle do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { article: }
  end
  let(:article) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:)
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(full_name: "Fumiko")
  end
  let(:body) { "some body" }
  let(:title) { "some title" }

  before do
    FoobaraDemo::Blog::EditArticle.run!(article:, body:, title:)
  end

  context "when not published" do
    it "publishes the article" do
      expect(article).to_not be_published
      expect(outcome).to be_success

      new_article = FoobaraDemo::Blog::FindArticle.run!(article:)

      expect(new_article).to be_published
      expect(new_article.body).to eq(body)
      expect(new_article.title).to eq(title)
      expect(new_article.published_at).to be_a(Time)
      expect(new_article.originally_published_at).to be_a(Time)
    end
  end
end
