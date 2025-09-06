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
        published_at :datetime, :allow_nil
        originally_published_at :datetime, :allow_nil
        last_edited_at :datetime
      end

      primary_key :id

      def body
        if published?
          current_published_version
        else
          current_draft
        end.body
      end

      def title
        if published?
          current_published_version
        else
          current_draft
        end.title
      end

      def published?
        is_published
      end
    end
  end
end
