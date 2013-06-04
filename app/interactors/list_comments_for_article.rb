class ListCommentsForArticle

  def exec(article_id)
    comments = Couchbase::CommentRepository.comments_for_article_by_date(article_id, 10)
    Response.new(comments: comments)
  end

end



