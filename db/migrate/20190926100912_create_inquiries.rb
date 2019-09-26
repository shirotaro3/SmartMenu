class CreateInquiries < ActiveRecord::Migration[5.2]
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :message
      t.integer :shop_id
      t.string :shop_name
      t.string :email

      t.timestamps
    end
  end
end
