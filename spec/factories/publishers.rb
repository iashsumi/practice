FactoryBot.define do
  factory :publisher do
    name { "MyString" }

    trait :invalid do
      name { nil }
    end
  
    trait :company do
      name { 'company' }
    end
  
    trait :test do
      name { 'test' }
    end
  end
end
