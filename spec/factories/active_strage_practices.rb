FactoryBot.define do
  factory :active_strage_practice do
    name { 'MyString' }

    trait :invalid do
      name { nil }
    end
  end
end
