class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.integer :user_id, null: false
      t.integer :shop_id, null: false
      t.string :email, null: false, default: ''
      t.text :message, null: false, default: ''
      t.string :title, null: false, default: ''
      t.timestamps
    end
  end
end
