class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :errorStr, type: String

  validate :check_ng_word

=begin
  Article モデルのname プロパティにNGワードチェックバリデーションを追加する
  NGワード
  江頭、タイツ、露出狂、2:50
  NGワードは配列でクラス定数で用意すること
=end
  def check_ng_word
    errorStr = ["江頭", "タイツ", "露出狂", "2:50"]
    errors.add(:name, "使えない文字列が含まれています") if errorStr.include? name
  end
end