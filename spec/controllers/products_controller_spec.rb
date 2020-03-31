require "rails_helper"

describe ProductsController, type: :controller do
    describe "GET #index" do
        it "成功" do
            expect(response.status).to eq 200
        end
    end
    describe "#create" do
      context "request is succeed" do
        it "returns success message" do
          microtaskhub = ProductsController.new
          allow(microtaskhub).to receive(:http_method) { {"header" => 200, "body" => "test is created"} }
          expect(microtaskhub.create()).to eq "200 : test is created"
        end
      end
    end
  end