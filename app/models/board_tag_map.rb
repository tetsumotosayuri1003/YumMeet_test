class BoardTagMap < ApplicationRecord
  belongs_to :board
  belongs_to :tag
end
