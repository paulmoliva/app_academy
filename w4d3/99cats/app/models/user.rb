class User < ActiveRecord::Base
  #getters/setters
  attr_reader :password

  #validations
  validates :username, :session_token, :password_digest , presence: true
  validates :username, :session_token, uniqueness: true

  after_initialize :reset_session_token!

  #associations
  has_many :cats

  has_many :sessions


  #class methods
  def self.generate_session_token
    SecureRandom::urlsafe_base64(32)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  #methods

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  def reset_session_token!
    self.session_token ||= User.generate_session_token
  end
end
