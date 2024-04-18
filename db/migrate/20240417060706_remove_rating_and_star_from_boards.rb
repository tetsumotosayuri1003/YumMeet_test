class RemoveRatingAndStarFromBoards < ActiveRecord::Migration[7.1]
  def change
    remove_column :boards, :rating, :integer
    remove_column :boards, :star, :integer
  end
end
