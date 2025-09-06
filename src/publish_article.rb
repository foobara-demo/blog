module FoobaraDemo
  module Blog
    class PublishArticle < Foobara::Command
      inputs do
        article Article, :required
      end

      result Article

      def execute
        determine_timestamp

        set_published_version
        set_is_published
        update_timestamps

        article
      end

      attr_accessor :now

      def determine_timestamp
        self.now = Time.now
      end

      def set_is_published
        article.is_published = true
      end

      def set_published_version
        article.current_published_version = article.current_draft
        article.current_draft = nil
      end

      def update_timestamps
        article.originally_published_at ||= now
        article.published_at = now
      end
    end
  end
end
