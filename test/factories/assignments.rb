FactoryBot.define do
  factory :assignment do
    store_id {1}
    employee_id {1}
    start_date {Date.current}
    end_date {nil}
  end
end
