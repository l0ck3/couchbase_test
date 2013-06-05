# encoding: utf-8

module Admin
  class AdminController < ApplicationController
    before_filter :require_admin

    protected

    def require_admin
      require_login

      unless current_user.admin?
        redirect_to root_path, alert: "Vous n'êtes pas autorisé à accéder à cette partie de l'application"
      end
    end

  end
end
