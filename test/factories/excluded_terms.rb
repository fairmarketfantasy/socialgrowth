# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :excluded_term do
    search_term
    text "humidity"
  end
end
