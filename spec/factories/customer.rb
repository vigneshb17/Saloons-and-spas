FactoryBot.define do
  factory :customer do
    email { 'vignesh@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end