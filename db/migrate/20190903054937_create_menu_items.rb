class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.integer :item_group_id, null: false
      t.string :item_image_id
      t.string :item_name, null: false, default: ''
      t.text :item_text
      t.integer :price, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
