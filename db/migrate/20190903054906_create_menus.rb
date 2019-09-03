class CreateMenus < ActiveRecord::Migration[5.2]
  def change
    create_table :menus do |t|
      t.string :menu_name, null: false, default: ''
      t.time :start_time
      t.time :end_time
      t.date :start_date
      t.date :end_date
      t.timestamps
    end
  end
end
