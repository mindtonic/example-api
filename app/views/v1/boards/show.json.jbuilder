json.board @board, partial: 'v1/boards/board', as: :board
json.saved_boards @board.saved_boards, partial: 'v1/boards/board', as: :board
