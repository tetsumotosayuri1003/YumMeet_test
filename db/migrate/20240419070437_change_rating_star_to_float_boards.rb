class ChangeRatingStarToFloatBoards < ActiveRecord::Migration[7.1]
  def change
    change_column :boards, :rating_star, :float
  end
end
