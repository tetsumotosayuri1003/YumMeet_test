class FavoritesController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    current_user.favorite(@board)
  end

  def destroy
    @board = current_user.favorites.find(params[:id]).board
    current_user.unfavorite(@board)
  end
end
