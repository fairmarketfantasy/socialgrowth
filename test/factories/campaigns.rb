FactoryGirl.define do

  factory :campaign do
    association :authentication, factory: :twitter
  end

end