module FoobaraDemo
  module Blog
    class User < Foobara::Entity
      attributes do
        id :integer
        full_name :string, :required
        bio :string, :allow_nil, "Bio in Markdown"
      end

      primary_key :id
    end
  end
end
