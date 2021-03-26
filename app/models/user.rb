class User < ApplicationRecord

  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 225 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  has_many :checklists, dependent: :destroy

  # 記憶トークンをハッシュ化⇨記憶ダイジェスト
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # トークンとユーザーを紐付け、記憶ダイジェストをDBに保存する
  def remember
    self.remember_token = User.new_token
    # validationを無視して更新(remember_digestにハッシュ化したremember_tokenを)
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 記憶ダイジェストとcookieの記憶トークン(をハッシュ化したもの)を比較、認証となればtrue
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end

  # 生年月日から年齢を計算する
  def age
    d1 = self.dob.strftime("%Y%m%d").to_i
    d2 = Date.today.strftime("%Y%m%d").to_i
    (d2 - d1) / 10000
  end

end