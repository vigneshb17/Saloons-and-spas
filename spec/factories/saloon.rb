FactoryBot.define do
  factory :saloon do
    company_name { 'saloon' }
    total_chairs_count { 5 }
    available_chairs_count { 5 }
    working_hours_from { '9:00' }
    working_hours_to { '18:00' }

    trait :saloons do
      sequence(:company_name) { |n| "saloon-#{n}" }
    end

    factory :saloons, traits: [:saloons]
  end
end