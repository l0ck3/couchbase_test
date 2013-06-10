class ListCommentsForArticle

  def do(article_id)
    comments = CommentRepository.all_comments_for_article_by_date(
      startkey: [article_id, 1000],
      endkey: [article_id, -1000],
      descending: true,
      limit: 20,
      reduce: false
    )
    Response.new(comments: comments)
  end

end



