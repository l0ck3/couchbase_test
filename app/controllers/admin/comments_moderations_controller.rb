# encoding: utf-8

module Admin
  class CommentsModerationsController < AdminController

    def index
      page   = (params[:page] || 1)
      unless params[:filter]
        params[:filter] = {moderation: 0}
      end

      @article             = ShowArticle.new.do(params[:id])
      @comments            = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], params[:filter][:moderation])

      @total_count         = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], 0).comments.total_rows
      @not_moderated_count = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], 1).comments.total_rows
      @positive_count      = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], 3).comments.total_rows
      @negative_count      = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], 4).comments.total_rows
      @neutral_count       = ListPendingCommentsForArticle.new(current_user, page).do(params[:id], 5).comments.total_rows

    end

    def create
      comment_id       = params[:id]
      moderation_value = params[:value]

      @comment = ModerateComment.new(current_user).do(comment_id, moderation_value)
      redirect_to action: :index, id: @comment.comment.article_id
    end

  end
end
