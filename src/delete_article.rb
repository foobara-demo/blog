module FoobaraDemo
  module Blog
    class DeleteArticle < Foobara::Command
      inputs do
        article Article, :required
      end

      def execute
        collect_versions_to_delete
        delete_all_versions
        delete_article

        nil
      end

      attr_accessor :versions_to_delete

      def collect_versions_to_delete
        self.versions_to_delete = [
          *article.past_published_versions,
          *article.current_draft,
          *article.current_published_version
        ].uniq
      end

      def delete_all_versions
        versions_to_delete.each(&:hard_delete!)
      end

      def delete_article
        article.hard_delete!
      end
    end
  end
end
