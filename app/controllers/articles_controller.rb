class ArticlesController < ApplicationController
  before_filter :require_login, only: [:new, :create, :delete]

  def index
    @rm = ListLastArticles.new.exec
  end

  def new
    @rm = NewArticle.new.exec
  end

  def create
    @rm = CreateArticle.new.exec(params[:article], current_user)
    @rm.success? ? redirect_to(articles_path) : render(:new)
  end

  def show
    @rm  = ShowArticle.new.exec(params[:id])
    @cm  = NewComment.new(params[:id]).exec
    @csm = ListCommentsForArticle.new().exec(params[:id])
  end

  # HELPER METHODS

  # def current_user
  #   @current_user ||= User.find_by_id!(session[:user_id])
  # end
  # helper_method :current_user

end
