module FoobaraDemo
  module Blog
    class StartNewArticle < Foobara::Command
      inputs do
        author User, :required
        title :string, :required
      end

      result Article

      def execute
        build_timestamp
        create_draft_version
        create_article

        article
      end

      attr_accessor :article, :draft_version, :timestamp

      def build_timestamp
        self.timestamp = Time.now
      end

      def create_draft_version
        self.draft_version = ArticleVersion.create(created_at: timestamp, modified_at: timestamp, title:)
      end

      def create_article
        self.article = Article.create(
          author:,
          last_edited_at: timestamp,
          current_draft: draft_version
        )
      end
    end
  end
end
