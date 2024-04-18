class AddRatingToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :rating, :integer
  end
end
