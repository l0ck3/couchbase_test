class CommentRepository
  include Whenua::Repository

  index :all_comments_for_article_by_date

  # def self.moderated_comments_for_article_by_date(article_id, limit=10)
  #   ddoc = bucket.design_docs['comment']

  #   ddoc.moderated_comments_for_article_by_date(end_key: [article_id], start_key: ["#{article_id}\u0fff"], descending: true, limit: limit).map do |row|
  #     row.value['id'] = row.id
  #     row.value
  #   end
  # end

  # def self.all_comments_for_article_by_date(article_id, moderation_status, page, limit=10)
  #   ddoc = bucket.design_docs['comment']

  #   params = {
  #     endkey: [article_id],
  #     startkey: ["#{article_id}"],
  #     limit: limit,
  #     descending: true
  #   }

  #   if result = boundaries_for_moderation_status(moderation_status)
  #     params[:startkey] << result[:start]
  #     params[:endkey] << result[:end]
  #   else
  #     params[:startkey][0] += '\u0fff'
  #   end

  #   count = ddoc.all_comments_for_article_by_date(params).first

  #   count = count ? count.value : 0

  #   collection = Collection.new(page, limit, count)

  #   params.merge!(skip: collection.skip_value, reduce: false) # TODO : Skip is slow. Find a way to manage it with keys

  #   results = ddoc.all_comments_for_article_by_date(params).map do |row|
  #     row.value['id'] = row.id
  #     row.value
  #   end

  #   collection.array = results
  #   collection
  # end

end

