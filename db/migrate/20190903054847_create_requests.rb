class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :shop_id, null: false
      t.text :message, null: false
      t.string :title, null: false, default: ''
      t.timestamps
    end
  end
end
