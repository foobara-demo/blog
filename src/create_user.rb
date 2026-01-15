module FoobaraDemo
  module Blog
    class Register < Foobara::Command
      inputs do
        blog_slug :string, :required
        full_name :string, :required
      end

      result User

      def execute
        create_blog_user

        user
      end

      attr_accessor :user

      def create_blog_user
        self.user = User.create(full_name:, blog_slug:)
      end
    end
  end
end
