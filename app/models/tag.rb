class Tag < ApplicationRecord
  has_many :board_tag_maps
  has_many :boards, through: :board_tag_maps
end
