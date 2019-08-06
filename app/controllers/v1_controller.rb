class V1Controller < ApplicationController
  before_action :find_board

private

  def find_board
    begin
      @board = Board.find_by_public_token!(params[:public_token])
    rescue ActiveRecord::RecordNotFound
      render json: {error: "Board Not Found"}, status: 404
    end
  end

end
