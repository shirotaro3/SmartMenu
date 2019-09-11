class CreateGrins < ActiveRecord::Migration[5.2]
  def change
    create_table :grins do |t|
      t.integer :shop_id, null: false
      t.timestamps
    end
  end
end
