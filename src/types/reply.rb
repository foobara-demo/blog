module FoobaraDemo
  module Blog
    class Reply < Foobara::Entity
      attributes do
        id :integer
        author User, :required

        # TODO: Foobara currently doesn't support self-referential data so we can't have a
        # reply to a reply. We could figure out a way to support this in a future version
        # if folks really want it.
        comment Comment, :required

        current_version ReplyVersion, :required
        past_reply_versions [ReplyVersion], default: []
        originally_replied_at :datetime, :required
        last_edited_at :datetime, :allow_nil
      end

      primary_key :id
    end
  end
end
