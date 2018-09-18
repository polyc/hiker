class AddHikePrefColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :hike_pref, :string
  end
end
