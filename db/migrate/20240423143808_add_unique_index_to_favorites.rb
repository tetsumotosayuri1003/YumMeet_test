class AddUniqueIndexToFavorites < ActiveRecord::Migration[7.1]
  def change
    add_index :favorites, [:user_id, :board_id, :favorite_type], unique: true
  end
end
