class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :message, type: String
  field :age, type: Integer
  field :mail_address, type: String

  has_many :products

  # いろんなバリデーション

  # 文字の長さ
  validates :name, length: {minimum: 5, maximum: 10, message: "エラー"}
  # これを省略しないとこうなるらしい
  validates(:name, {:length => {:minimum => 5, :maximum => 10, :message => "エラー"}})
  # 文字の長さ２
  # validates :name, length: { in: 5..10 }
  # 文字数指定
  # validates :name, length: { is: 5 }
  # 正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail_address, presence: {message: "エラー"}, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end