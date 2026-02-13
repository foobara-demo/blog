module FoobaraDemo
  module Blog
    class UnpublishArticle < Foobara::Command
      inputs do
        article Article, :required
      end

      result Article

      def execute
        determine_timestamp

        clear_is_published_flag
        rotate_published_version_to_draft
        update_timestamps

        article
      end

      attr_accessor :timestamp

      def determine_timestamp
        self.timestamp = Time.now
      end

      def clear_is_published_flag
        article.is_published = false
      end

      def rotate_published_version_to_draft
        current_version = article.current_published_version

        article.current_draft = ArticleVersion.create(
          modified_at: timestamp,
          created_at: timestamp,
          body: current_version.body,
          title: current_version.title
        )
        article.current_version = article.current_draft

        article.past_published_versions = [
          article.current_published_version,
          *article.past_published_versions
        ]

        article.current_published_version = nil
      end

      def update_timestamps
        article.published_at = nil
        article.unpublished_at = timestamp
      end
    end
  end
end
