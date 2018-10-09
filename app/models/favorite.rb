class Favorite < ActiveRecord::Base
  belongs_to :favoritable, class_name: "Hike"
  belongs_to :favoriter, class_name: "User"

    validates :favoriter_id, presence: true
    validates :favoritable_id, presence: true
end
