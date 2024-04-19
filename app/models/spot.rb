class Spot < ApplicationRecord
  has_many :boards, dependent: :destroy
  # APIから取得した他の情報も将来的にはここに追加する予定

  validates :name, presence: true
end
