require_relative "article"

module FoobaraDemo
  module Blog
    class Comment < Foobara::Entity
      attributes do
        id :integer
        author User, :required

        article Article, :required

        current_version CommentVersion, :required
        past_comment_versions [CommentVersion], default: []
        originally_commented_at :datetime, :required
        last_edited_at :datetime, :allow_nil
      end

      primary_key :id
    end
  end
end
