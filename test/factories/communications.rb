# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :communication do
    search_string "MyString"
    text_found "MyString"
    text_sent "MyString"
    username "MyString"
    authentication_id 1
  end
end
