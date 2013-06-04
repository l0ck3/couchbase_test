class NewComment

  def initialize(article_id)
    @article_id = article_id
  end

  def exec
    comment = Comment.new(article_id: @article_id)
    Response.new(comment: comment)
  end

end
