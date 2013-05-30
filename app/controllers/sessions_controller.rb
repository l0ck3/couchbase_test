# encoding: utf-8

class SessionsController < ApplicationController


  def new

  end

  def create
    rm = UserAuthentication.new.authenticate(params[:credentials][:login], params[:credentials][:password])

    if rm.success?
      auto_login rm.user
      redirect_back_or_to(:root, notice: 'Vous êtes maintenant connecté.')
    else
      flash.now[:alert] = "Authentification échouée." # TODO : Message should not be set in plain text here
      render(:new)
    end
  end

  def destroy

  end

end
