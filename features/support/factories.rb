FactoryGirl.define do
  factory :admin do
    initialize_with { new(attributes) }
  end
end