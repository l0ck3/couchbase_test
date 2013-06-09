class CountTotalArticles
  def do
    count = ArticleRepository.count_total_articles

    Response.new(count: count.first)
  end
end
