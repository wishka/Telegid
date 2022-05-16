class Customer < ApplicationRecord
  include PgSearch::Model
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  has_many :posts, dependent: :destroy
  has_many :telechannels
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  pg_search_scope :search_everywhere, against: [:name, :email]

  def Customer.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def Customer.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Customer.new_token
    update_attribute(:remember_digest, Customer.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Активирует аккаунт.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Отправляет электронное письмо для активации.
  def send_activation_email
    CustomerMailer.account_activation(self).deliver_now
  end

  # Устанавливает атрибуты для сброса пароля.
  def create_reset_digest
    self.reset_token = Customer.new_token
    update_attribute(:reset_digest,  Customer.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Отправляет электронное письмо для сброса пароля.
  def send_password_reset_email
    CustomerMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Возвращает ленту сообщений пользователя.
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :customer_id"
    Post.where("customer_id IN (#{following_ids})
                     OR customer_id = :customer_id", customer_id: id)
  end

  # Начать читать сообщения пользователя.
  def follow(other_customer)
    active_relationships.create(followed_id: other_customer.id)
  end

  # Перестать читать сообщения пользователя.
  def unfollow(other_customer)
    active_relationships.find_by(followed_id: other_customer.id).destroy
  end

  # Возвращает true, если текущий пользователь читает сообщения другого пользователя.
  def following?(other_customer)
    following.include?(other_customer)
  end

  private

    def downcase_email
      self.email = email.downcase
    end

    # Создает и присваивает активационнй токен и дайджест.
    def create_activation_digest
      self.activation_token  = Customer.new_token
      self.activation_digest = Customer.digest(activation_token)
    end
end
