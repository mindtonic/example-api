class Save < ApplicationRecord

  #
  # Associations
  #

  belongs_to :board
  belongs_to :saved_board, class_name: "Board"

end
