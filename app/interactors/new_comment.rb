class NewComment

  def initialize(article_id)
    @article_id = article_id
  end

  def do
    comment = Comment.new(article_id: @article_id)
    Response.new(comment: comment)
  end

end
