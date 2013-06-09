class ArticlesController < ApplicationController
  before_filter :require_login, only: [:new, :create, :delete]

  def index
    @rcount = CountTotalArticles.new.do
    @rm = ListLastArticles.new.do
  end

  def new
    @rm = NewArticle.new.do
  end

  def create
    @rm = CreateArticle.new.do(params[:article], current_user)
    @rm.success? ? redirect_to(articles_path) : render(:new)
  end

  def show
    @rm  = ShowArticle.new.do(params[:id])
    @cm  = NewComment.new(params[:id]).do
    @csm = ListCommentsForArticle.new().do(params[:id])
  end

  def destroy
    DeleteArticle.new.do(params[:id])
    redirect_to action: :index
  end

  # HELPER METHODS

  # def current_user
  #   @current_user ||= User.find_by_id!(session[:user_id])
  # end
  # helper_method :current_user

end
