class CreateDeletedShops < ActiveRecord::Migration[5.2]
  def change
    create_table :deleted_shops do |t|

      t.string :shop_name, null: false, default: ''
      t.string :postal_code, null: false, default: ''
      t.integer :state, null: false
      t.string :city, null: false, default: ''
      t.string :street, null: false, default: ''
      t.string :phone_number, null: false, default: ''
      t.string :email, null: false, default: ''

      t.timestamps
    end
  end
end
