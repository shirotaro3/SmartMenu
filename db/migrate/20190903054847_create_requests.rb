class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :user_id, null: false, default: 0
      t.integer :shop_id, null: false, default: 0
      t.text :message, null: false, default: ''
      t.string :title, null: false, default: ''
      t.timestamps
    end
  end
end
