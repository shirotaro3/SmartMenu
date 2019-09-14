class CreateTaxes < ActiveRecord::Migration[5.2]
  def change
    create_table :taxes do |t|
      t.decimal :rate, precision: 6, scale: 3, null: false
      t.timestamps
    end
  end
end
