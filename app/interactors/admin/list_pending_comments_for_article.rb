# encoding: utf-8

module Admin
  class ListPendingCommentsForArticle

    def initialize(user, page=1)
      @user = user
      @page = page
    end

    def do(article_id, moderation_status)
      raise 'Opération non permise' unless @user.admin?

      limit = 20

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

      count = CommentRepository.all_comments_for_article_by_date(params).first
      count = count ? count : 0

      collection = Whenua::Collection.new(@page, limit, count)

      params.merge!(skip: collection.skip_value, reduce: false) # TODO : Skip is slow. Find a way to manage it with keys

      comments = CommentRepository.all_comments_for_article_by_date(params)
      collection.array = comments

      Response.new(comments: collection)
    end

  private

  def boundaries_for_moderation_status(status)
    result = case status
    when '1' then {end: 'null',   start: 'null\u0fff'}
    when '2' then {end: -1000, start: 1000}
    when '3' then {end: 1,     start: 1000}
    when '4' then {end: -1000, start: -1 }
    when '5' then {end: 0,     start: 0}
    else false
    end
  end

  end
end
