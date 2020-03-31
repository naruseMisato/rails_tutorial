# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
    factory :testProduct, class: Product do
      name { "iPhoneSE" }
    end
  end