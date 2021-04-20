class User < ApplicationRecord

  attr_accessor :remember_token, :reset_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 225 },
  format: { with: VALID_EMAIL_REGEX }, uniqueness:{ case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  validates :dob, presence: true
  validates :sex, presence: true

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
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest") #sendは動的にメソッドを呼び出してくれる
    return false if remember_digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
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

  # professionカラムの定義
  enum profession: {
    Dr: 0, Ns: 1, PT: 2, OT: 3, ST: 4, 薬剤師: 5, 栄養士: 6, MSW: 7
  }

  # sexカラムの定義
  enum sex: {
    男性: 0, 女性: 1
  }

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する,deliver_nowは即時送信
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パスワード再設定の期限が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
end