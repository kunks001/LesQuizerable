# Factory.define :admin do |f|
#   f.title "A post title"
# end

FactoryGirl.define do
  factory :admin do
    # sequence(:email) { |n| "person_#{n}@example.com"}   
    email "test@test.com"
    password "foobar"
    password_confirmation "foobar"
  end
end