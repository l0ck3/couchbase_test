class User < ActiveRecord::Base
  authenticates_with_sorcery!

  attr_accessor :password_confirmation

  attr_accessible :username, :email, :password, :password_confirmation

  validates :username,              presence:   true,
                                    uniqueness: true

  validates :email,                 presence:   true,
                                    uniqueness: true

  validates :password,              presence:     true,
                                    confirmation: true

  validates :password_confirmation, presence: true


  def admin?
    self.admin
  end

end
