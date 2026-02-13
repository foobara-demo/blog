RSpec.describe FoobaraDemo::Blog::FindArticleSummaries do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { author:  }
  end
  let!(:article1) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:, title: "first article")
  end
  let!(:article2) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:, title: "second article")
  end
  let(:author) do
    FoobaraDemo::Blog::CreateUser.run!(blog_slug: "fumiko", full_name: "Fumiko")
  end

  it "is successful" do
    expect(outcome).to be_success
    expect(result).to be_an(Array)
    expect(result.map(&:current_title)).to contain_exactly("first article", "second article")

    result.each do |article_summary|
      expect(article_summary).to be_a(FoobaraDemo::Blog::ArticleSummary)
      expect(article_summary).to_not be_published
    end
  end
end
