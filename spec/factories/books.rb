FactoryBot.define do
  factory :book do
    author
    publisher
    title { "MyString" }

    trait :invalid do
      author
      publisher
      title { nil }
    end
  
    trait :one_peace do
      author
      publisher
      title { 'one_peace' }
    end
  
    trait :test do
      author
      publisher
      title { 'test' }
    end
  end
end
