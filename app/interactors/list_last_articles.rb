class ListLastArticles

  def do
    articles = ArticleRepository.all_articles_by_date(limit: 10, descending: true)

    Response.new(articles: articles)
  end

end
