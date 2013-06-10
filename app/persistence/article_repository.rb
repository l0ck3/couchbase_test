class ArticleRepository
  include Whenua::Repository

  index :count_total_articles
  index :all_articles_by_date
end

