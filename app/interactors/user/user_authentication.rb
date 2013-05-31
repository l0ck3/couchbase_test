class UserAuthentication

  def authenticate(login, password)
    user = User.authenticate(login, password)

    if user
      Response.new(user: user)
    else
      Response.new(errors: :authentication_failed)
    end
  end

end
