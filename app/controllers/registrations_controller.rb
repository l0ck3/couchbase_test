class RegistrationsController < ApplicationController

  def new
    @rm = UserRegistration.new.new_user
  end


  def create
    @rm = UserRegistration.new.register(params[:user])
    @rm.success? ? redirect_to(root_path) : render(:new)
  end

end
