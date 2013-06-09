class ArticleRepository
  include Whenua::Repository

  index :count_total_articles
  index :all_articles_by_date, limit: 10, descending: true

end

