class CreateItemGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_groups do |t|
      t.integer :category_id, null: false

      t.timestamps
    end
  end
end
