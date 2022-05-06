class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(post)
    mine = ApplicationController.render(
      partial: 'posts/mine',
      locals: {post: post}
      )

    theirs = ApplicationController.render(
      partial: 'posts/theirs',
      locals: {post: post}
      )

    ActionCable.server.broadcast "room_channel_#{post.room_id}",
                                    main: main, theirs: theirs,
                                    post: post

  end
end
