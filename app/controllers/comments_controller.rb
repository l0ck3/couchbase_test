# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :require_login, only: [:create]

  def create
    @rm = CreateComment.new(current_user).exec(params[:comment])

    flash[:error] = "Votre commentaire n'a pas été ajouté" unless @rm.success?
    redirect_to(article_path(params[:comment][:article_id]))
  end

  def show
    @rm = Articles::ShowArticle.new.exec(params[:id])
  end

end

