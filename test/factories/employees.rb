FactoryBot.define do
  factory :employee do
    first_name {"Alex"}
    last_name {"Heimann"}
    ssn {"123456789"}
    date_of_birth {"1999-11-19}"
    phone {"4128978970"}
    role {1}
    active {true}
  end
end