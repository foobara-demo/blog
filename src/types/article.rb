require_relative "user"

module FoobaraDemo
  module Blog
    class Article < Foobara::Entity
      attributes do
        id :integer
        author User, :required
        is_published :boolean, default: false
        current_published_version ArticleVersion, :allow_nil
        current_draft ArticleVersion, :allow_nil
        past_published_versions [ArticleVersion], default: []
        originally_published_at :datetime, :allow_nil
        last_edited_at :datetime
      end

      primary_key :id
    end
  end
end
