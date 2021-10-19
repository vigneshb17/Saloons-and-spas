class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.time :from_time
      t.time :to_time
      t.date :booking_date
      t.integer :status
      t.references :customer, :saloon, :chair, :service

      t.timestamps
    end
  end
end
