class AddMapImageToHike < ActiveRecord::Migration[5.1]
  def change
    add_column :hikes, :map_image, :string
  end
end
