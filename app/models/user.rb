class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader
  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_boards, through: :favorites, source: :board

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }
  validates :email, presence: true, uniqueness: true

  def slug_candidates
    [
      :first_name,
      [:first_name, :last_name],
      [:first_name, :last_name, :id] # ユニーク性を保証するためにIDを組み合わせる
    ]
  end

  def should_generate_new_friendly_id?
    first_name_changed? || last_name_changed? || super
  end

  def own?(object)
    id == object&.user_id
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def favorite(board)
    favorite_boards << board
  end

  def unfavorite(board)
    favorite_boards.destroy(board)
  end

  def favorite?(board)
    favorite_boards.include?(board)
  end
end
