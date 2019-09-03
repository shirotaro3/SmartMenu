class CreateShopImages < ActiveRecord::Migration[5.2]
  def change
    create_table :shop_images do |t|
      t.integer :shop_id, null: false, default: 0
      t.string :shop_image_id, null: false, default: ''
      t.string :image_name, null: false, default: ''
      t.integer :position, null: false, default: 0
      t.timestamps
    end
  end
end
