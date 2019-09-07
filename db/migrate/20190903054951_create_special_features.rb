class CreateSpecialFeatures < ActiveRecord::Migration[5.2]
  def change
    create_table :special_features do |t|
      t.integer :menu_id, null: false, default: 0
      t.string :feature_image_id, null: false, default: ''
      t.string :title, null: false, default: ''
      t.text :body, null: false, default: ''
      t.string :column_color, null: false, default: '#ffffff'
      t.timestamps
    end
  end
end
