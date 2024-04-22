class BoardsController < ApplicationController
  before_action :require_login, only: %i[index new create show edit update destroy]

  def index
    @boards = Board.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
    @board.build_spot
  end

  def create
    @board = Board.new(board_params)
    @board.user = current_user
    if @board.save
      redirect_to boards_path, success: "投稿しました"
    else
      flash.now[:alert] = "投稿できませんでした"
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit
    @board = current_user.boards.find(params[:id])
  end

  def update
    @board = current_user.boards.find(params[:id])
    if @board.update(board_params)
      redirect_to board_path(@board), success: "更新しました"
    else
      flash.now[:alert] = "更新できませんでした"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = current_user.boards.find(params[:id])
    ActiveRecord::Base.transaction do
      board.board_tag_maps.destroy_all
      board.destroy!
    end
    redirect_to boards_path, success: "削除しました"
  end

  private

  def board_params
    params.require(:board).permit(:comment, :board_image, :board_image_cache, :rating_star, tag_ids: [], spot_attributes: [:name])
  end
end
