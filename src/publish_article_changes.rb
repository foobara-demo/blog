module FoobaraDemo
  module Blog
    class PublishArticleChanges < Foobara::Command
      inputs do
        article Article, :required
      end

      result Article

      def execute
        determine_timestamp

        save_previously_published_version
        rotate_draft_to_published
        update_timestamps

        article
      end

      attr_accessor :timestamp

      def determine_timestamp
        self.timestamp = Time.now
      end

      def save_previously_published_version
        article.past_published_versions = [
          article.current_published_version,
          *article.past_published_versions
        ]
      end

      def rotate_draft_to_published
        article.current_version = article.current_published_version = article.current_draft
        article.current_draft = nil
      end

      def update_timestamps
        article.last_edited_at = timestamp
        article.current_published_version.modified_at = timestamp
      end
    end
  end
end
