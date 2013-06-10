class CreateArticle

  def do(params, poster)
    article      = Article.new(params)
    article.user = poster

    if Couchbase::ArticleRepository.save(article)
      Response.new(article: article)
    else
      Response.new(article: article, errors: article.errors)
    end
  end

end
