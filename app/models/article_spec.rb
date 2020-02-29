require "rspec"

RSpec.describe Article, type: :model do
    describe '#check_protection_organization' do
      subject { Article.new.check_protection_organization }
      context '初めての投稿で里親カテゴリの場合' do
        # 正常
      end
      context '初めての投稿で売買カテゴリの場合' do
        # 正常
      end
      context '４回目(閾値)の投稿で売買カテゴリの場合' do
        # 正常
      end
      context '４回目(閾値)の投稿で里親カテゴリの場合' do
        # 異常
      end
    end
  end