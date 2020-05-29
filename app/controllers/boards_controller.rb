class BoardsController < ApplicationController
  before_action :set_target_board, only: %i[show edit update destroy]
  before_action :require_user_logged_in

  def index
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    @boards = @boards.page(params[:page]).order(id: :desc)
  end

  def new
    if logged_in?
      @board = current_user.boards.build(flash[:board])
    end
  end

  def create
    board = current_user.boards.build(board_params)
    if board.save
      flash[:notice] = "「#{board.title}」の募集を作成しました"
      redirect_to board
    else
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  def show
    @comment = current_user.comments.build(board_id: @board.id)
  end

  def edit
  end

  def update
    @board.update(board_params)
    redirect_to @board
  end

  def destroy
    @board.destroy
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました"}
  end

  private

  def board_params
    params.require(:board).permit(:title, :platform, :content, tag_ids: [])
  end

  def set_target_board
    @board = Board.find(params[:id])
  end
end
