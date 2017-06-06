class User < ApplicationRecord
  before_save {email.downcase!}

  validates :name, presence: true, length: {maximum: Settings.user.name.max}
  VALIDATE_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.user.email.max},
  format: {with: VALIDATE_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true,
    length: {minium: Settings.user.password.min}
end
