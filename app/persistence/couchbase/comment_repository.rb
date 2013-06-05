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

    def self.moderated_comments_for_article_by_date(article_id, limit=10)
      ddoc = bucket.design_docs['comment']

      ddoc.moderated_comments_for_article_by_date(end_key: [article_id], start_key: ["#{article_id}\u0fff"], descending: true, limit: limit).map do |row|
        row.value['id'] = row.id
        row.value
      end
    end

    def self.all_comments_for_article_by_date(article_id, moderation_status, page, limit=10)
      ddoc = bucket.design_docs['comment']

      params = {
        endkey: [article_id],
        startkey: ["#{article_id}"],
        limit: limit,
        descending: true
      }

      if result = boundaries_for_moderation_status(moderation_status)
        params[:startkey] << result[:start]
        params[:endkey] << result[:end]
      else
        params[:startkey][0] += '\u0fff'
      end

      count = ddoc.all_comments_for_article_by_date(params).first

      count = count ? count.value : 0

      collection = Collection.new(page, limit, count)

      params.merge!(skip: collection.skip_value, reduce: false) # TODO : Skip is slow. Find a way to manage it with keys

      results = ddoc.all_comments_for_article_by_date(params).map do |row|
        row.value['id'] = row.id
        row.value
      end

      collection.array = results
      collection
    end

    def self.get(id)
      comment = Comment.new bucket.get(id)
      comment.instance_variable_set(:@id, id) if comment # TODO : Do something better
      comment
    end

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

    # TODO : This is application logic. It doesn't belong to the persistence layer. Move it to interactor.
    def self.boundaries_for_moderation_status(status)
      result = case status
        when '1' then {end: 'null',   start: 'null\u0fff'}
        when '2' then {end: -1000, start: 1000}
        when '3' then {end: 1,     start: 1000}
        when '4' then {end: -1000, start: -1 }
        when '5' then {end: 0,     start: 0}
        else false
      end
    end

    # TODO : Factor following code in parent Repository class
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



