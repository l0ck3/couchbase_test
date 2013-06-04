require 'securerandom'

module Couchbase
  class CommentRepository

    # def self.comments_by_date(limit=10)
    #   ddoc = bucket.design_docs["comment"]

    #   ddoc.all_comments_by_date(descending: true, limit: limit).map do |row|
    #     row.value['id'] = row.id
    #     row.value
    #   end
    # end

    def self.comments_for_article_by_date(article_id, limit=10)
      ddoc = bucket.design_docs['alerti_test']

      ddoc.all_comments_for_article_by_date(end_key: [article_id], start_key: ["#{article_id}\u0fff"], descending: true, limit: limit).map do |row|
        row.value['id'] = row.id
        row.value
      end
    end

    # def self.get(id)
    #   comment.new bucket.get(id)
    # end

    def self.save(comment)
      return false unless comment.valid?

      comment.touch

      if comment.persisted?
        bucket.replace(comment.id, comment)
      else
        uuid = generate_id
        bucket.add(uuid, comment)
        comment.instance_variable_set(:@id, uuid)
      end

      comment
    end

  private

    def self.generate_id
      SecureRandom.uuid
    end

    def self.bucket
      @bucket ||= Couchbase.new(bucket: "alerti-test",
      :node_list => [
        '192.168.50.101'
        ])
    end

  end
end
