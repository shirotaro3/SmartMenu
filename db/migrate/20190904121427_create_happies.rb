class CreateHappies < ActiveRecord::Migration[5.2]
  def change
    create_table :happies do |t|
      t.integer :menu_item_id, null: false, default: ''
      t.integer :shop_id, null: false, default: ''
      t.timestamps
    end
  end
end
