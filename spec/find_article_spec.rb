RSpec.describe FoobaraDemo::Blog::FindArticle do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { article: article.id }
  end
  let(:article) do
    FoobaraDemo::Blog::StartNewArticle.run!(author:)
  end
  let(:author) do
    FoobaraDemo::Blog::Register.run!(
      username: "fumiko",
      email: "fumiko@example.com",
      plaintext_password: "pass",
      full_name: "Fumiko"
    )
  end

  it "is successful" do
    expect(outcome).to be_success
    expect(result).to be_a(FoobaraDemo::Blog::Article)
    expect(result).to eq(article)
  end
end
