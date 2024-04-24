class Board < ApplicationRecord
  mount_uploader :board_image, BoardImageUploader

  belongs_to :user
  belongs_to :spot
  accepts_nested_attributes_for :spot
  has_many :board_tag_maps
  has_many :tags, through: :board_tag_maps
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :tag_ids, presence: true
  validates :rating_star, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5, message: "は1から5の間で指定してください" }
end
