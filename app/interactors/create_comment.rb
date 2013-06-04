class CreateComment

  def initialize(user)
    @user       = user
  end

  def exec(params)
    comment      = Comment.new(params)
    comment.user = @user

    if Couchbase::CommentRepository.save(comment)
      Response.new(comment: comment)
    else
      Response.new(comment: comment, errors: comment.errors)
    end
  end

end
