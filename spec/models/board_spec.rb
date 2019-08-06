require 'rails_helper'

RSpec.describe Board, type: :model do
  it_behaves_like "a public token", Board

  #
  # Validations
  #

  it { should validate_presence_of(:name) }

  #
  # Associations
  #

  it { should have_many(:saves) }
  it { should have_many(:saved_boards).through(:saves) }

end
