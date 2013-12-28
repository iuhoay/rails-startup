class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true, uniqueness: { case_sensitive: false }, length: { in: 3..20 }, on: :create

  validates :email, presence: true, uniqueness: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/ }
  validates :password, presence: true, length: { in: 6..16 }

  validates :password, confirmation: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  before_create :email_lower

  private
    
    def email_lower
      self.email = self.email.downcase
    end
end
