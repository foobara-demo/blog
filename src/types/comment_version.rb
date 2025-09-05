module FoobaraDemo
  module Blog
    class CommentVersion < Foobara::Entity
      attributes do
        id :integer
        body :string, :required
        created_at :datetime, :required
      end

      primary_key :id
    end
  end
end
