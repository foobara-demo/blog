module FoobaraDemo
  module Blog
    class User < Foobara::Entity
      attributes do
        id :integer
        auth_user Foobara::Auth::Types::User, :required, :private
        full_name :string, :required
        blog_slug :string
        bio :string, default: "", description: "Bio in Markdown"
      end

      primary_key :id

      delegate_attribute :username, :auth_user
      delegate_attribute :email, :auth_user
    end
  end
end
