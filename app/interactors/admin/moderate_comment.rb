module Admin
  class ModerateComment

    def initialize(user)
      @user = user
    end

    def exec(comment_id, moderation)
      comment = Couchbase::CommentRepository.get(comment_id)

      comment.moderate(moderation)
      Couchbase::CommentRepository.save(comment)
      Response.new(comment: comment)
    end

  end
end
