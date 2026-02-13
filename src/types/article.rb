require_relative "user"

module FoobaraDemo
  module Blog
    class Article < Foobara::Entity
      attributes do
        id :integer
        author User, :required
        is_published :boolean, default: false
        current_version ArticleVersion, :required,
                        "If published, will be the published version. Otherwise, the latest draft."
        current_published_version ArticleVersion, :allow_nil
        current_draft ArticleVersion, :allow_nil
        past_published_versions [ArticleVersion], default: []
        published_at :datetime, :allow_nil
        unpublished_at :datetime, :allow_nil
        originally_published_at :datetime, :allow_nil
        last_edited_at :datetime
      end

      primary_key :id

      delegate_attribute :title, :current_version
      delegate_attribute :body, :current_version

      def published?
        is_published
      end
    end
  end
end
