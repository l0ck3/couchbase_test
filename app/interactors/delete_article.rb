class DeleteArticle

  def exec(id)
    article = Couchbase::ArticleRepository.delete(id)
  end

end
