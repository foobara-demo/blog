module FoobaraDemo
  module Blog
    class FindArticle < Foobara::Command
      inputs do
        article Article, :required
        # Why do we do this here instead of in the command connector??
        aggregate :boolean, default: false
        load_paths :duck,
                   default: [],
                   description: "Can pass a collection of paths to pre-emptively load them"
      end

      result Article

      def execute
        # TODO: why would this be necessary??
        unless aggregate?
          load_current_versions
          load_associations
        end

        article
      end

      def load_records
        if aggregate?
          Article.load_aggregate(article)
        else
          super
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
        # TODO: we should be able to do this from the command connector (not yet implemented but we should)
        if load_paths && !load_paths.empty?
          Article.load(article, load_paths:)
        end
      end
    end
  end
end
