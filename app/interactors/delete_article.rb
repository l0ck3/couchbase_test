class DeleteArticle

  def do(id)
    ArticleRepository.delete(id)
  end

end
