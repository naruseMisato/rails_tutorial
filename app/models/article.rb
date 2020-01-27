class Article
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :title, type: String
  field :text, type: String
  field :published_at, type: DateTime
  field :pv_count, type: Integer

  # 課題①
  /*
  Article モデルのtitle に以下のバリデーションを記述する
  presence バリデーション
  メッセージ「タイトルは入力必須です」
  20文字length バリデーション
  メッセージ「タイトルは20文字以内で入力してください」
  */
  # バリデーションヘルパー
  validates :title, presence:{message: "タイトルは入力必須です"},length: {maximum: 20, message: "タイトルは20文字以内で入力してください"}
end