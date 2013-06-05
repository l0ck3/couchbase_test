module Admin
  class ListPendingCommentsForArticle

    def initialize(user, page=1)
      @user = user
      @page = page
    end

    def exec(article_id, moderation_status)
      comments = Couchbase::CommentRepository.all_comments_for_article_by_date(article_id, moderation_status, @page, 20)
      Response.new(comments: comments)
    end

  end
end
