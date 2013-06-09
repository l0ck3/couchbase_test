# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

user = User.first

10000.times do
  article = Article.new(
    title: Faker::Lorem.sentence,
    content: Faker::Lorem.paragraphs(rand(50) + 1).join
  )

  article.user = user

  begin
    ArticleRepository.save(article)
  rescue Exception => e
    puts "Article write failed ! : #{e}"
  end

end


# 1000000.times do |i|
#   comment = Comment.new(
#     content: "#{i} - A comment", #Faker::Lorem.paragraphs(rand(50) + 1).join,
#     article_id: "179a2a10-f4ed-4ac5-b763-4af210da247f"
#   )

#   comment.user = user

#   begin
#     Couchbase::CommentRepository.save(comment)
#   rescue Exception => e
#     puts "Comment write failed ! : #{e}"
#   end
# end
