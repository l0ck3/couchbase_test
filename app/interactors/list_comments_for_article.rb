class ListCommentsForArticle

  def exec(article_id)
    comments = Couchbase::CommentRepository.moderated_comments_for_article_by_date(article_id, 10)
    Response.new(comments: comments)
  end

end



