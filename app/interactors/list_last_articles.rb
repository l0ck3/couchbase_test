class ListLastArticles

  def exec
    articles = Couchbase::ArticleRepository.articles_by_date
    Response.new(articles: articles)
  end

end
