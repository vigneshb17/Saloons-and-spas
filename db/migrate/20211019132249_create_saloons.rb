class CreateSaloons < ActiveRecord::Migration[6.1]
  def change
    create_table :saloons do |t|
      t.string :company_name
      t.string :address
      t.string :GSTIN
      t.string :pan_number
      t.integer :total_chairs_count
      t.integer :available_chairs_count
      t.time :working_hours_from
      t.time :working_hours_to

      t.timestamps
    end
  end
end
