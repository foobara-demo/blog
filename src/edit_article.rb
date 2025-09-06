module FoobaraDemo
  module Blog
    class EditArticle < Foobara::Command
      inputs do
        article Article, :required
        title :string, :allow_nil
        body :string, :allow_nil, description: "The new body of the article in Markdown"
      end

      result Article

      possible_error :neither_title_nor_body_provided
      possible_error :unchanged

      def execute
        determine_timestamp
        determine_new_title_and_body

        if published?
          create_new_draft_version_if_needed
        end

        update_draft_version

        article
      end

      attr_accessor :timestamp, :new_title, :new_body

      def determine_timestamp
        self.timestamp = Time.now
      end

      def determine_new_title_and_body
        self.new_title = if title
                           title.strip
                         else
                           article.title
                         end

        self.new_body = if body
                          body.strip
                        else
                          article.body
                        end
      end

      def validate
        validate_title_or_body_present
        validate_title_or_body_changed
      end

      def validate_title_or_body_present
        if title.nil? || title.strip.empty?
          if body.nil? || body.strip.empty?
            add_runtime_error :neither_title_nor_body_provided
          end
        end
      end

      def validate_title_or_body_changed
        if title
          if title.strip != article.title
            return
          end
        end

        if body
          if body.strip != article.body
            return
          end
        end

        add_runtime_error :unchanged
      end

      def published?
        article.published?
      end

      def create_new_draft_version_if_needed
        if article.current_draft.nil?
          article.current_draft = ArticleVersion.create(
            created_at: timestamp,
            modified_at: timestamp,
            title: article.title,
            body: article.body
          )
        end
      end
      # def create_new_published_version
      #   article.last_edited_at = timestamp
      #
      #   article.past_published_versions = [
      #     article.current_published_version,
      #     *article.past_published_versions
      #   ]
      #
      #   article.current_published_version = ArticleVersion.create(
      #     title: new_title,
      #     body: new_body,
      #     created_at: timestamp,
      #     modified_at: timestamp
      #   )
      # end

      def update_draft_version
        draft = article.current_draft

        draft.title = new_title
        draft.body = new_body
        draft.modified_at = timestamp
      end
    end
  end
end
