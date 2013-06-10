# encoding: utf-8

module Admin
  class ModerateComment

    def initialize(user)
      @user = user
    end

    def do(comment_id, moderation)
      raise 'Opération non permise' unless @user.admin?

      comment = CommentRepository.find_by_id(comment_id)

      comment.moderate(moderation)
      CommentRepository.save(comment)
      Response.new(comment: comment)
    end

  end
end
