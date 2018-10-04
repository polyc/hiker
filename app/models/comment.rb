class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :hike

  validates :comment, :length => { :in => 1..256}
end
