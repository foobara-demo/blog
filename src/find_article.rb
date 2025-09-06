module FoobaraDemo
  module Blog
    class FindArticle < Foobara::Command
      inputs do
        article Article, :required
      end

      result Article

      def execute
        load_current_versions

        article
      end

      def load_current_versions
        [article.current_published_version, article.current_draft].compact.each do |version|
          ArticleVersion.load(version)
        end
      end
    end
  end
end
