# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

user = User.first

100000.times do
  article = Article.new(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraphs(rand(50) + 1)
  )

  article.user = user

  begin
    Couchbase::ArticleRepository.save(article)
  rescue Exception => e
    puts "Article write failed ! : #{e}"
  end

end
