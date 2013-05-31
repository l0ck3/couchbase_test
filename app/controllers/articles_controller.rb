class ArticlesController < ApplicationController
  before_filter :require_login, only: [:new, :create]

  def index
    @rm = Articles::ListLastArticles.new.exec
  end

  def new
    @rm = NewArticle.new.exec
  end

  def create
    @rm = CreateArticle.new.exec(params[:article], current_user)
    @rm.success? ? redirect_to(articles_path) : render(:new)
  end

  def show
    @rm = Articles::ShowArticle.new.exec(params[:id])
  end

end
