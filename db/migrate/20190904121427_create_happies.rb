class CreateHappies < ActiveRecord::Migration[5.2]
  def change
    create_table :happies do |t|
      t.integer :shop_id, null: false
      t.timestamps
    end
  end
end
