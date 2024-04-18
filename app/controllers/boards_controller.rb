class BoardsController < ApplicationController
  def index
    @boards = Board.includes(:user)
  end

  def new
    @board = Board.new
    @board.build_spot
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user  # 現在のユーザーを投稿者として設定
    if @board.save
      redirect_to boards_path, success: "投稿しました"
    else
      flash.now[:alert] = "投稿できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:comment, :board_image, :board_image_cache, :rating_star, tag_ids: [], spot_attributes: [:name])
  end
end
