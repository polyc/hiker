class AddFavoriteTable < ActiveRecord::Migration[5.1]
  def change
    create_table :favorites do |t|
      t.integer :favoriter_id
      t.integer :favoritable_id

      t.timestamps
    end
    add_index :favorites, :favoritable_id
    add_index :favorites, [:favoriter_id, :favoritable_id], unique: true
  end
end
