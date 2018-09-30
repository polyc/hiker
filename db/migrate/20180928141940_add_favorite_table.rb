class AddFavoriteTable < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :favoritable_id
      t.string :favoritable_type

      t.timestamps
    end
    add_index :favorites, :favoritable_id
    add_index :favorites, :favoritable_type
    add_index :favorites, [:favoritable_id, :favoritable_type], unique: true
  end
end
