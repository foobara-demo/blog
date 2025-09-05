module FoobaraDemo
  module Blog
    class User < Foobara::Entity
      attributes do
        id :integer
        full_name :string, :required
        bio :string, default: "", description: "Bio in Markdown"
      end

      primary_key :id
    end
  end
end
