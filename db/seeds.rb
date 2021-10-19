# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Customer.create!(email: 'vignesh@gmail.com', password: 'password', password_confirmation: 'password')

1..10.times do |n|
 saloon = Saloon.create!(company_name: Faker::Company.name, address: Faker::Address.street_address, total_chairs_count: n,
                         available_chairs_count: n, working_hours_from: '9:00', working_hours_to: '18:00')

 Service.create!(service_type: 'hair_cut', price: 10 * n, timings_in_mins: n * 5, saloon_id: saloon.id)
 Service.create!(service_type: 'shaving', price: 5 * n, timings_in_mins: n * 2, saloon_id: saloon.id)
end
