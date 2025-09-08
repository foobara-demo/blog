module FoobaraDemo
  module Blog
    class FindArticle < Foobara::Command
      inputs do
        article Article, :required
        aggregate :boolean, default: false
        load_paths :duck,
                   default: [],
                   description: "Can pass a collection of paths to pre-emptively load them"
      end

      result Article

      def execute
        unless aggregate?
          load_current_versions
          load_associations
        end

        article
      end

      def load_records
        if aggregate?
          Article.load_aggregate(article)
        end
      end

      def aggregate?
        aggregate
      end

      def load_current_versions
        [article.current_published_version, article.current_draft].compact.each do |version|
          ArticleVersion.load(version)
        end
      end

      def load_associations
        if load_paths && !load_paths.empty?
          Article.load(article, load_paths:)
        end
      end
    end
  end
end
