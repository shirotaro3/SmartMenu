class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu_name, null: false, default: ''
      t.string :color, default: 'white'
      t.integer :shop_id, null: false
      t.timestamps
    end
  end
end
