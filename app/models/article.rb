
class Article
  include Whenua::Entity
  extend ActiveModel::Naming # FIXME : Alreadi present in Entity. Find why it is necessary to include it here again

  attribute :content,     String
  attribute :title,       String
  attribute :user_id,     Integer
  attribute :username,    String

  # validates :title,    presence: true
  # validates :content,  presence: true
  # validates :user_id,  presence: true
  # validates :username, presence: true

  def user=(user)
    self.user_id  = user.id
    self.username = user.username
  end

end
