class CreateChairs < ActiveRecord::Migration[6.1]
  def change
    create_table :chairs do |t|
      t.boolean :available
      t.references :saloon

      t.timestamps
    end
  end
end
