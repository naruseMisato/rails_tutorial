# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
    factory :testUser, class: User do
      name { "naruse" }
      mail_address { "misato.naruse+85648@jmty.jp" }
      is_protection_organization { false }
    end
end