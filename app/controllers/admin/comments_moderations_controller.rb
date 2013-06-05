# encoding: utf-8

module Admin
  class CommentsModerationsController < AdminController

    def index
      page   = (params[:page] || 1)
      unless params[:filter]
        params[:filter] = {moderation: 0}
      end

      @article  = ShowArticle.new.exec(params[:id])
      @comments = ListPendingCommentsForArticle.new(current_user, page).exec(params[:id], params[:filter][:moderation])
    end

    def create
      comment_id       = params[:id]
      moderation_value = params[:value]

      @comment = ModerateComment.new(current_user).exec(comment_id, moderation_value)
      redirect_to action: :index, id: @comment.comment.article_id
    end

  end
end
