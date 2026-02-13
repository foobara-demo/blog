require_relative "user"

module FoobaraDemo
  module Blog
    class ArticleSummary < Foobara::Model
      attributes do
        article_id :integer, :required
        author User, :required
        is_published :boolean, default: false
        published_at :datetime, :allow_nil
        unpublished_at :datetime, :allow_nil
        current_title :string, :required
        originally_published_at :datetime, :allow_nil
        last_edited_at :datetime
      end

      def published?
        is_published
      end
    end
  end
end
