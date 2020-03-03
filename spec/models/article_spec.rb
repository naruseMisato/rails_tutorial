require "rails_helper"

describe Article, type: :model do
  describe "#check_protection_organization" do
    let(:user) { User.create(params) }
    let(:params) { { name: "naruse",
                     mail_address: "misato.naruse+11@jmty.jp",
                     is_protection_organization: is_protection_organization } }
    subject { user.articles[-1].valid? }
    context "愛護団体ではない＆初めての投稿で里親カテゴリの場合" do
      let(:is_protection_organization) { false }
      it "成功する" do
        first_article = user.articles.build(category_id: "2", title: "test")
        is_expected.to eq true
      end
    end
    context "愛護団体ではない＆初めての投稿で売買カテゴリの場合" do
      let(:is_protection_organization) { false }
      it "成功する" do
        first_article = user.articles.build(category_id: "1", title: "test")
        is_expected.to eq true
      end
    end
    context "愛護団体ではない＆4回目(閾値)の投稿で里親カテゴリの場合" do
      let(:is_protection_organization) { false }
      it "失敗する" do
        first_article = user.articles.build(category_id: "2", title: "test")
        second_article = user.articles.build(category_id: "2", title: "test2")
        third_article = user.articles.build(category_id: "2", title: "test3")
        
        p(user.articles)
        p(user.articles.count)
        p(user.articles.where(category_id: "2").count)

        fourth_article = user.articles.build(category_id: "2", title: "test4")
        is_expected.to eq false
      end
    end
    context "愛護団体ではない＆4回目(閾値)の投稿で売買カテゴリの場合" do
      let(:is_protection_organization) { false }
      it "成功する" do
        first_article = user.articles.build(category_id: "1", title: "test")
        second_article = user.articles.build(category_id: "1", title: "test2")
        third_article = user.articles.build(category_id: "1", title: "test3")

        fourth_article = user.articles.build(category_id: "1", title: "test4")
        is_expected.to eq true
      end
    end
    context "愛護団体＆4回目(閾値)の投稿で里親カテゴリの場合" do
      let(:is_protection_organization) { true }
      it "成功する" do
        first_article = user.articles.build(category_id: "2", title: "test")
        second_article = user.articles.build(category_id: "2", title: "test2")
        third_article = user.articles.build(category_id: "2", title: "test3")

        fourth_article = user.articles.build(category_id: "1", title: "test4")
        is_expected.to eq true
      end
    end
    context "愛護団体＆4回目(閾値)の投稿で売買カテゴリの場合" do
      let(:is_protection_organization) { true }
      it "成功する" do
        first_article = user.articles.build(category_id: "1", title: "test")
        second_article = user.articles.build(category_id: "1", title: "test2")
        third_article = user.articles.build(category_id: "1", title: "test3")

        fourth_article = user.articles.build(category_id: "1", title: "test4")
        is_expected.to eq true
      end
    end
  end
end
