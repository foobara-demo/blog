module FoobaraDemo
  module Blog
    class ReplyVersion < Foobara::Entity
      attributes do
        id :integer
        body :string, :required
        created_at :datetime, :required
      end

      primary_key :id
    end
  end
end
