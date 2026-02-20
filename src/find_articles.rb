module FoobaraDemo
  module Blog
    class FindArticles < Foobara::Query
      inputs do
        author User, :required
      end

      result [Article]

      def execute
        find_articles_for_user

        articles
      end

      attr_accessor :articles

      def find_articles_for_user
        self.articles = Article.find_all_by_attribute(:author, author)
      end
    end
  end
end
