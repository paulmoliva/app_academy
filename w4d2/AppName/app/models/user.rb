class User < ActiveRecord::Base
  before_validation :ensure_session_token
  validates :username, :session_token, presence: true
  validates :password_digest, presence: {message: "password cant be blank"}
  valiates :password, minimum: {8}, allow_nil: true

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save!
  end

  def ensure_session_token
    @session_token ||= User.generate_session_token
  end

  def password=(input)
    @password = input
    self.password_digest = BCrypt::Password.create(input)
  end
end
