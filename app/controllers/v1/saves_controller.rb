class V1::SavesController < V1Controller
  before_action :find_saveable_board

  #
  # Create
  #

  def create
    @board.saved_boards << @saveable_board
    render 'v1/boards/show'
  end

  #
  # Destroy
  #

  def destroy
    @board.saved_boards.delete(@saveable_board)
    render 'v1/boards/show'
  end

private

  def find_saveable_board
    begin
      @saveable_board = Board.find_by_public_token!(params[:saveable_token])
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Board Not Found"}, status: 404
    end
  end
end
