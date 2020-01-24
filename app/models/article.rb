class Article
  include Mongoid::Document
  include Mongoid::Timestamps
    
  field :title, type: String
  field :text, type: String
  field :published_at, type: DateTime
  field :pv_count, type: Integer

  validate :is_required_check
  validate :length_range

  def is_required_check
    if title.blank?
      errors.add(:title, "タイトルは入力必須です")
    end
  end

  def length_range
    if title.count > 20
      errors.add(:title, "20文字以内で入力してください")
    end
  end
end