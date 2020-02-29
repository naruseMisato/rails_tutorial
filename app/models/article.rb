class Article
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :category_id, type: String # ２＝里親とする
  field :title, type: String
  field :text, type: String
  field :published_at, type: DateTime
  field :pv_count, type: Integer

  belongs_to :user

=begin
  課題①
  Article モデルのtitle に以下のバリデーションを記述する
  presence バリデーション
  メッセージ「タイトルは入力必須です」
  20文字length バリデーション
  メッセージ「タイトルは20文字以内で入力してください」
=end
  # バリデーションヘルパー
  validates :title, presence:{message: "タイトルは入力必須です"},length: {maximum: 20, message: "タイトルは20文字以内で入力してください"}
  validate :check_protection_organization

private
  # 投稿IDが里親の場合 && ユーザが愛護団体じゃない場合 && 里親で３回投稿したとことがある場合はエラーを返す
  def check_protection_organization
    if category_id.eql?("2") && # -> 里親カテゴリ : 2
      !user.get_is_protection_organization &&
      user.posted_article_foster_parent_count > 3
      errors.add(:is_protection_organization, "愛護団体じゃない場合、３回までしか里親カテゴリは投稿できません") 
    end
  end
end