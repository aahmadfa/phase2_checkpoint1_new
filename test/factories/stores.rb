FactoryBot.define do
  factory :store do
    name { "Coffee Bean" }
    street { "MyStreet" }
    city { "MyCity" }
    state { "PA" }
    zip { "59100" }
    phone { "1234567890" }
    active { true }
  end
end

