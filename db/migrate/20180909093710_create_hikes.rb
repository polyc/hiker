class CreateHikes < ActiveRecord::Migration[5.1]
  def change
    create_table :hikes do |t|
      t.string :name
      t.string :route
      t.text :equipment
      t.string :difficulty
      t.float :distance
      t.float :avg_time
      t.text  :nature
      t.float :max_height
      t.float :min_height
      t.float :level_difference
      t.float :rating
      t.string :tipo
      t.text :description

      t.timestamps
    end
  end
end
