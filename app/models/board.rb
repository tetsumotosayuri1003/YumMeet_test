class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader

  belongs_to :user
  belongs_to :spot
  accepts_nested_attributes_for :spot
  has_many :board_tag_maps
  has_many :tags, through: :board_tag_maps

  validates :tag_ids, presence: true

  enum rating_star: {
    '5': 5,
    '4 and a half': 4.5,
    '4': 4,
    '3 and a half': 3.5,
    '3': 3,
    '2 and a half': 2.5,
    '2': 2,
    '1 and a half': 1.5,
    '1': 1,
    'half': 0.5
  }
end
