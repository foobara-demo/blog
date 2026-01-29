RSpec.describe FoobaraDemo::Blog::FindArticles do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { author:  }
  end
  let!(:article1) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:)
  end
  let!(:article2) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:)
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(blog_slug: "fumiko", full_name: "Fumiko")
  end

  it "is successful" do
    expect(outcome).to be_success
    expect(result).to be_an(Array)
    expect(result).to contain_exactly(article1, article2)
  end
end
