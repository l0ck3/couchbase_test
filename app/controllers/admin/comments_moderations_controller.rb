module Admin
  class CommentsModerationsController < AdminController

    def index
      page = (params[:page] || 1)
      @article  = ShowArticle.new.exec(params[:id])
      @comments = ListPendingCommentsForArticle.new(current_user, page).exec(params[:id], params[:filter][:moderation])
    end

  end
end
