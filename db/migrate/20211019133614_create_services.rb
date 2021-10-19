class CreateServices < ActiveRecord::Migration[6.1]
  def change
    create_table :services do |t|
      t.integer :type
      t.integer :timings_in_mins
      t.integer :price
      t.references :saloon

      t.timestamps
    end
  end
end
