require 'rails_helper'

describe Article, type: :model do
  describe '#check_protection_organization' do
    context '愛護団体ではない＆初めての投稿で里親カテゴリの場合' do
      # userの初期化
      it "成功する" do
        user = User.create(name: "naruse", mail_address: "misato.naruse+11@jmty.jp", is_protection_organization: false)
        # 投稿作成
        first_article = user.articles.build(category_id: "2", title: "test")
        # validationを走らせて、それの結果をtrueと比較
        expect(first_article.valid?).to eq true
      end
    end
  end
end
