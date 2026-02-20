require_relative "find_articles"

module FoobaraDemo
  module Blog
    class FindArticleSummaries < Foobara::Query
      inputs do
        author User, :required
      end

      result [ArticleSummary]

      depends_on FindArticles

      def execute
        find_articles_for_user
        build_article_summaries

        article_summaries
      end

      attr_accessor :articles, :article_summaries

      def find_articles_for_user
        self.articles = run_subcommand!(FindArticles, author:)
      end

      def build_article_summaries
        attributes_to_copy = Article.attribute_names - [:id,
                                                        :current_version,
                                                        :current_published_version,
                                                        :current_draft,
                                                        :past_published_versions,
                                                        :title,
                                                        :body]

        self.article_summaries = articles.map do |article|
          article_summary_attributes = {
            article_id: article.id,
            current_title: article.current_version.title
          }

          attributes_to_copy.each do |attribute_name|
            article_summary_attributes[attribute_name] = article.read_attribute(attribute_name)
          end

          ArticleSummary.new(article_summary_attributes)
        end
      end
    end
  end
end
