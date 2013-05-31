require 'securerandom'

module Couchbase
  class ArticleRepository

    def self.articles_by_date(limit=10)
      ddoc = bucket.design_docs["article"]

      ddoc.all_articles_by_date(descending: true, limit: limit).map do |row|
        row.value[:id] = row.id
        row.value
      end
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
      @bucket ||= Couchbase.new(bucket: "alerti-test",
      :node_list => [
        '192.168.42.101',
        '192.168.42.102',
        '192.168.42.103',
        '192.168.42.104'
        ])
    end

  end
end
