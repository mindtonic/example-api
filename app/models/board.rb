class Board < ApplicationRecord
  include PublicToken

  #
  # Validations
  #

  validates :name, presence: true

  #
  # Associations
  #

  has_many :saves
  has_many :saved_boards, through: :saves

end
