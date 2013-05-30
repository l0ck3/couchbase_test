class NewArticle

  def exec
    Response.new(article: Article.new)
  end

end
