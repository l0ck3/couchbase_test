require 'securerandom'

module Couchbase
  class ArticleRepository

    def self.articles_by_date(limit=10)
      ddoc = bucket.design_docs["article"]

      ddoc.all_articles_by_date(descending: true, limit: limit).map do |row|
        row.value['id'] = row.id
        row.value
      end
    end

    def self.count_total_articles
      ddoc = bucket.design_docs["article"]
      ddoc.count_total_articles.first.value
    end

    def self.delete(id)
      ddoc = bucket.design_docs["comment"] # TODO : Move the deletion part in Comments repo and call from there

      comments_ids = ddoc.comments_ids_for_article().each do |row|
        bucket.delete(row.value)
      end

      bucket.delete(id)
    end

    def self.get(id)
      article = Article.new bucket.get(id)
      article.instance_variable_set(:@id, id) if article # TODO : Do something better
      article
    end

    def self.save(article)
      return false unless article.valid?

      article.touch

      if article.id
        bucket.replace(article.id, article)
      else
        uuid = generate_id
        bucket.add(uuid, article)
        article.instance_variable_set(:@id, uuid)
      end

      article
    end

  private

    def self.generate_id
      SecureRandom.uuid
    end

    def self.bucket
      @bucket ||= Couchbase.new(
        bucket: "alerti-test",
        :hostname => 'ec2-54-216-72-40.eu-west-1.compute.amazonaws.com',
        :password => 'muy8(uah'
      )
    end

  end
end
