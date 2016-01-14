class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..20 }, on: :create

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }
  validates :password, presence: true, length: { in: 6..16 }

  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_create :email_lower, :generate_avatar

  scope :recent, -> { order("id desc") }

  def remember_token
    [id, Digest::SHA512.hexdigest(password_digest)].join('$')
  end

  def self.find_by_remember_token(token)
    user = first(conditions: { id: token.split('$').first })
    if user && user.remember_token == token
      user
    else
      nil
    end
  end

  def to_param
    name
  end

  def admin?
    APP_CONFIG['admin_emails'].include?(self.email)
  end

  private

    def email_lower
      self.email = self.email.downcase
    end

    def generate_avatar
      self.avatar_base = RubyIdenticon.create_base64(self.name)
    end
end
