class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :surname
      t.string :email
      t.string :password_digest
      t.date :birthday
      t.integer :gender_id

      t.timestamps
    end
  end
end
