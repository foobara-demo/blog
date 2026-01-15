RSpec.describe FoobaraDemo::Blog::UnpublishArticle do
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
    FoobaraDemo::Blog::Register.run!(blog_slug: "fumiko", full_name: "Fumiko")
  end
  let(:body) { "some body" }
  let(:title) { "some title" }

  before do
    FoobaraDemo::Blog::EditArticle.run!(article:, body:, title:)
    FoobaraDemo::Blog::PublishArticle.run!(article:)
  end

  it "unpublishes the article" do
    updated_article = FoobaraDemo::Blog::FindArticle.run!(article:)

    expect(updated_article).to be_published

    expect(outcome).to be_success

    updated_article = FoobaraDemo::Blog::FindArticle.run!(article:, aggregate: true)

    expect(updated_article).to_not be_published
    expect(updated_article.body).to eq(body)
    expect(updated_article.title).to eq(title)
    expect(updated_article.published_at).to be_nil
    expect(updated_article.unpublished_at).to be_a(Time)
    expect(updated_article.originally_published_at).to be_a(Time)
  end
end
