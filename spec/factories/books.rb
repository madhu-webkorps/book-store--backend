FactoryGirl.define do 
    factory :book do 
        id {Faker::Number.number(1)}
       name { Faker::Name.name}
       author { Faker::Name.name}
       edition { Faker::Name.name}
       quantity { Faker::Number.number(2)}
    end
end