class AddHikeImageToHikes < ActiveRecord::Migration[5.1]
  def change
    add_column :hikes, :hike_image, :string
  end
end
