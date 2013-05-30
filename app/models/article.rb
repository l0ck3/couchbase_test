
class Article
  include Virtus
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_reader :id, :created_at, :updated_at

  attribute :title,    String
  attribute :content,  String
  attribute :user_id,  Integer
  attribute :username, String

  validates :title,    presence: true
  validates :content,  presence: true
  validates :user_id,  presence: true
  validates :username, presence: true

  def touch
    now         = Time.now.utc
    @created_at = now if @created_at.nil?
    @updated_at = now
  end

  def persisted?
    id.present?
  end

  def user=(user)
    self.user_id  = user.id
    self.username = user.username
  end

end
