RSpec.describe FoobaraDemo::Blog::CreateUser do
  let(:command) { described_class.new(inputs) }
  let(:outcome) { command.run }
  let(:result) { outcome.result }
  let(:inputs) do
    { blog_slug:, full_name: }
  end
  let(:blog_slug) { "some_blog_slug" }
  let(:full_name) { "Some Username" }

  it "creates a user" do
    expect(outcome).to be_success
    expect(result).to be_a(FoobaraDemo::Blog::User)
    expect(result.full_name).to eq(full_name)
    expect(result.blog_slug).to eq(blog_slug)
  end
end
