FactoryBot.define do
  factory :hair_cut_service, class: :Service do
    service_type { 'hair_cut' }
    timings_in_mins { 20 }
    price { 100 }
  end
end