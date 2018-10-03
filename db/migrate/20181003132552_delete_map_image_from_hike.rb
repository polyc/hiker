class DeleteMapImageFromHike < ActiveRecord::Migration[5.1]
  def change
    remove_column :hikes, :map_image
  end
end
