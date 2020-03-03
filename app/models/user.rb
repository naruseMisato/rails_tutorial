class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :message, type: String
  field :age, type: Integer
  field :mail_address, type: String
  field :is_protection_organization, type: Boolean

  has_many :articles

  # いろんなバリデーション
  # 文字の長さ
  validates :name, length: {minimum: 5, maximum: 10, message: "エラー"}
  # これを省略しないとこうなるらしい
  validates(:name, {:length => {:minimum => 5, :maximum => 10, :message => "エラー"}})
  # 正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :mail_address, presence: {message: "エラー"}, uniqueness: true, format: { with: VALID_EMAIL_REGEX }

  # 愛護団体かどうか
  # def get_is_protection_organization
  #   is_protection_organization
  # end

  # 過去に里親カテゴリで投稿した数
  def posted_article_foster_parent_count
    articles.where(category_id: "2").count
  end
end