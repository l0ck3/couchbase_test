require 'securerandom'

module Couchbase
  class ArticleRepository

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
      @bucket ||= Couchbase.new(bucket: "alerti-test", hostname: "192.168.42.101")
    end

  end
end
