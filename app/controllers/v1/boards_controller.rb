class V1::BoardsController < V1Controller
  skip_before_action :find_board, only: [:index]

  #
  # Index
  #

  def index
    @boards = Board.page(params[:page])
  end

  #
  # Show
  #

  def show
  end

end
