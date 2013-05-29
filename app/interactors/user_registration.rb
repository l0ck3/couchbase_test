class UserRegistration

  def new_user
    Response.new(user: User.new)
  end

  def register(params)
    user = User.new(params)

    if user.save
      Response.new(user: user)
    else
      Response.new(user: user, errors: user.errors)
    end
  end

end
