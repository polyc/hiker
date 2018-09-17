class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :gender
      t.datetime :birthdate
      t.string :nickname
      t.string :email
      t.text :description
      t.string :city
      t.string :encrypted_password
      t.string :salt
      t.string :hike_pref

      t.timestamps
    end
  end
end
