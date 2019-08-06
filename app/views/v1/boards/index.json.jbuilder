json.partial! '/shared/pagination', collection: @boards
json.boards @boards, partial: 'board', as: :board
