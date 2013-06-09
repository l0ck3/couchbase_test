class ListLastArticles

  def do
    articles = ArticleRepository.all_articles_by_date

    Response.new(articles: articles)
  end

end
