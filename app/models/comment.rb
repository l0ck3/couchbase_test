class Comment
  include Virtus
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_reader :id

  attribute :article_id,  Integer
  attribute :content,     String
  attribute :created_at,  String  # TODO : Implement custom serialization and remove it from attributes
  attribute :type,        String  # TODO : Implement custom serialization and remove it from attributes
  attribute :updated_at,  String  # TODO : Implement custom serialization and remove it from attributes
  attribute :user_id,     Integer
  attribute :username,    String
  attribute :moderation,  Integer


  validates :article_id,  presence: true
  validates :content,     presence: true
  validates :user_id,     presence: true
  validates :username,    presence: true

  def moderate(value)
    self.moderation = value
  end

  def persisted?
    id.present?
  end

  def touch
    now         = Time.now.utc
    @created_at = now if @created_at.nil?
    @updated_at = now
  end

  def type
    self.class.name.downcase
  end

  def user=(user)
    self.user_id  = user.id
    self.username = user.username
  end

end
