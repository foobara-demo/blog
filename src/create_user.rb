module FoobaraDemo
  module Blog
    class CreateUser < Foobara::Command
      inputs User.attributes_for_create
      result User

      def execute
        create_user

        user
      end

      attr_accessor :user

      def create_user
        self.user = User.create(inputs)
      end
    end
  end
end
