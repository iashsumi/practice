FactoryBot.define do
  factory :user do
    name { 'testuser1' }

    trait :invalid do
      name { nil }
    end

    trait :admin do
      name { 'admin' }
    end

    trait :test do
      name { 'test' }
    end
  end
end
