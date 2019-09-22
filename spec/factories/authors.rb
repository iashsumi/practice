FactoryBot.define do
  factory :author do
    name { "MyString" }
    
    trait :invalid do
      name { nil }
    end
  
    trait :oda do
      name { 'oda' }
    end
  
    trait :test do
      name { 'test' }
    end
  end
end
