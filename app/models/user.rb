class User < ApplicationRecord
  before_save { self.email = email.downcase } # DBへの保存時に全てのメールアドレスを小文字にする
  # ちなみに代入式の両辺に self が出てくる場合、右辺の self は省略できる
  # before_save { email.downcase! } でも可
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
