class AddRatingStarToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :rating_star, :integer
  end
end
