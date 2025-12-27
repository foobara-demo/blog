module FoobaraDemo
  module Blog
    class Register < Foobara::Command
      depends_on Foobara::Auth::Register

      inputs do
        username :string, :required
        email :email, :allow_nil
        plaintext_password :string, :allow_nil, :sensitive_exposed
        full_name :string, :required
      end

      result User

      def execute
        create_auth_user
        create_blog_user

        user
      end

      attr_accessor :auth_user, :user

      def create_auth_user
        self.auth_user = run_subcommand!(Foobara::Auth::Register, username:, email:, plaintext_password:)
      end

      def create_blog_user
        self.user = User.create(auth_user:, full_name:, blog_slug: username)
      end
    end
  end
end
