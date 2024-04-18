class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader

  belongs_to :user
  belongs_to :spot
  accepts_nested_attributes_for :spot
  has_many :board_tag_maps
  has_many :tags, through: :board_tag_maps

  validates :comment, presence: true, length: { maximum: 20_535 }
end
