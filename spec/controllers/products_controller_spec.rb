require "rails_helper"

describe ProductsController, type: :controller do
    describe "GET #inde" do
        let(:user) { FactoryBot.create(:testUser) }
        let(:product) { FactoryBot.createt(:testProduct) }
        subject { user.articles[-1].valid? }
        before do
            User.destroy_all
            Product.destroy_all
        end
        it "成功" do
            expect(response.status).to eq 200
        end
        it ':newテンプレートを表示すること' do
            expect(response).to render_template :new
          end
    end
end