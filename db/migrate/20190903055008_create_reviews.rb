class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :comment, null: false, default: ''
      t.string :star_count, null: false, default: ''
      t.timestamps
    end
  end
end
