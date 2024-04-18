class AddStarToBoards < ActiveRecord::Migration[7.1]
  def change
    add_column :boards, :star, :integer
  end
end
