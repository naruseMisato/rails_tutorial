# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :article do
    name { "なるせ" }
    mail_address { "misato.naruse+11@jmty.jp" }
  end
end
