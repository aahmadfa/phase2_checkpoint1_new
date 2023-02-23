FactoryBot.define do
  factory :assignment do
    store_id {1}
    employee_id {1}
    start_date {"2023-01-01"}
    end_date {nil}
  end
end
