class Product
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String

  validate :check_ng_word

  def check_ng_word
    errors.add(:name, "使えない文字列が含まれています") if name&.eql? "なるせ"
  end
end