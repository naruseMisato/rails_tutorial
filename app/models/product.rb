class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  NG_WORDS = %w[江頭 タイツ 露出狂 2:50].freeze

  validate :check_ng_word

  belongs_to :user

=begin
  課題②
  Article モデルのname プロパティにNGワードチェックバリデーションを追加する
  NGワード
  江頭、タイツ、露出狂、2:50
  NGワードは配列でクラス定数で用意すること
=end
  private
   def check_ng_word
    errors.add(:name, "使えない文字列が含まれています") if NG_WORDS.any? { |data| name.include?(data) }
   end
end