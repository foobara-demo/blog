module FoobaraDemo
  module Blog
    class ArticleVersion < Foobara::Entity
      attributes do
        id :integer
        title :string, :required
        body :string, :required, "The body of the artcle in Markdown"
        published_at :datetime, :allow_nil
        created_at :datetime, :required
        modified_at :datetime, :required
      end

      primary_key :id
    end
  end
end
