class ListLastArticles

  def exec
    articles = Couchbase::ArticleRepository.articles_by_date(10)
    Response.new(articles: articles)
  end

end
