require 'ffaker'

module DataGenerator

  def self.client
    ::Whenua.data_store.client
  end

  def self.clean_data
    User.delete_all
    client.flush
  end

  def self.generate_base_users
    admin = User.new(
      username: 'admin',
      email: 'admin@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    admin.admin = true
    admin.save


    user = User.new(
      username: 'user',
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    user.save
  end

  def self.generate_user
    User.create(
    username: ::Faker::Internet.user_name,
    email: ::Faker::Internet.email,
    password: 'password',
    password_confirmation: 'password'
    )
  end

  def self.pick_random_user
    offset = rand(User.count)
    User.first(offset: offset)
  end

  def self.generate_article(user)
    article = Article.new(
    title: ::Faker::Lorem.sentence,
    content: ::Faker::Lorem.paragraphs(rand(10) + 1).join
    )

    article.user = user

    begin
      article = ArticleRepository.save(article)
    rescue Exception => e
      puts "Article write failed ! : #{e}"
    end
    article
  end


  def self.generate_comment(article, user)
    comment = Comment.new(
    content: Faker::Lorem.paragraph,
    article_id: article.id
    )

    comment.user = user

    begin
      CommentRepository.save(comment)
    rescue Exception => e
      puts "Comment write failed ! : #{e}"
    end
  end

end

namespace :dev do
  desc "Generates a development dataset"
  task :dataset => :environment do

    DataGenerator.clean_data

    puts "====> Generating users"
    DataGenerator.generate_base_users
    100.times do
      DataGenerator.generate_user
    end

    puts "====> Generating articles"
    10000.times do
      user    = DataGenerator.pick_random_user
      article = DataGenerator.generate_article(user)

      puts "  ==> Generating comments for article : #{article.title}"
      100.times do
        comment_user = DataGenerator.pick_random_user
        DataGenerator.generate_comment(article, comment_user)
      end

    end

  end

end



