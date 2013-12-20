FactoryGirl.define do

  factory :campaign do
    association :authentication, factory: :twitter
    title "Oracle"
  end

end