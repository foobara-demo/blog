require "foobara/all"
require "foobara/auth"

module FoobaraDemo
  foobara_organization!

  module Blog
    foobara_domain!

    foobara_depends_on Foobara::Auth
  end
end

Foobara::Util.require_directory "#{__dir__}/../../src"
