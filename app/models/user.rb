class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_create :create_activation_digest

  validates(:name, presence: true)
  validates :email, presence: true, uniqueness: true
  has_secure_password
  validates :password, presence: true, allow_nil: true

  def User.digest(string)
    cost =
      ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost

      BCrypt::Password.create(string, cost: cost)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
