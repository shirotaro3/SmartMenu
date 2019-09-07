class CreateItemGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :item_groups do |t|
      t.integer :category_id, null: false
      t.integer :menu_id, null: false
      t.string :group_image_id

      t.timestamps
    end
  end
end
