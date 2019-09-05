class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.integer :menu_id, null: false, default: 0
      t.string :item_image_id, null: false, default: ''
      t.string :item_name, null: false, default: ''
      t.text :item_text, null: false, default: ''
      t.integer :price, null: false, default: 0
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
