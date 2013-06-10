class ShowArticle

  def do(id)
    article = ArticleRepository.find_by_id(id)
    Response.new(article: article)
  end

end
