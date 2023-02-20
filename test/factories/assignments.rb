FactoryBot.define do
  factory :assignment do
    association :store, factory: :store
    association :employee, factory: :employee
    start_date { Date.today }
    active { true }

    factory :active_assignment do
      end_date { nil }
    end

    factory :inactive_assignment do
      end_date { 1.day.ago.to_date }
      active { false }
    end
  end
end

