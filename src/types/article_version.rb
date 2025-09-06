module FoobaraDemo
  module Blog
    class ArticleVersion < Foobara::Entity
      attributes do
        id :integer
        title :string, default: ""
        body :string, default: "", description: "The body of the article in Markdown"
        created_at :datetime, :required
        modified_at :datetime, :required
      end

      primary_key :id
    end
  end
end
