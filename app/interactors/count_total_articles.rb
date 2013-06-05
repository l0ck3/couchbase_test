class CountTotalArticles
  def exec
    count = Couchbase::ArticleRepository.count_total_articles
    Response.new(count: count)
  end
end
