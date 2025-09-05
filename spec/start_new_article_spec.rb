RSpec.describe FoobaraDemo::Blog::StartNewArticle do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:errors_hash) { outcome.errors_hash }

  let(:inputs) do
    { author: }
  end
  let(:author) { FoobaraDemo::Blog::CreateUser.run!(full_name: "Fumiko") }

  it "is successful" do
    expect(outcome).to be_success
    expect(result).to be_a(FoobaraDemo::Blog::Article)
  end
end
