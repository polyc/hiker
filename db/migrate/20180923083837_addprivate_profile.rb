class AddprivateProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :private_profile, :integer
  end
end
