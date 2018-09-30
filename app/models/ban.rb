class Ban < ApplicationRecord
  belongs_to :condemner, class_name: "User"
  belongs_to :banned, class_name: "User"

  validates :condemner_id, presence: true
  validates :banned_id, presence: true
end
