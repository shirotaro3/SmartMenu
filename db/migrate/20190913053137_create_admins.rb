class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      
      t.string :email, null: false
      t.string :password_digest, null: false
      t.string :remember_token
      t.timestamps
    end
  end
end
