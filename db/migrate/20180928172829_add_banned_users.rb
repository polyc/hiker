class AddBannedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :bans do |t|
      t.integer :condemner_id
      t.integer :banned_id

      t.timestamps
    end
    add_index :bans, :condemner_id
    add_index :bans, :banned_id
    add_index :bans, [:condemner_id, :banned_id], unique: true
  end
end
