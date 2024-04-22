class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 20_535 }

  belongs_to :user
  belongs_to :board
end
