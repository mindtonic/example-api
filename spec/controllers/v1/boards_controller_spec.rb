require "rails_helper"

RSpec.describe V1::BoardsController do
  let(:api_key) { create(:api_key, ip_address: "0.0.0.0") }
  let(:board) { create(:board) }
  let(:saveable_board) { create(:board) }
  let(:headers) { {
    "ACCEPT" => "application/json",
    "X-Api-Key" => api_key.key,
    "X-Api-Secret" => api_key.secret
  } }

  #
  # Index
  #

  describe "GET index" do
    before(:each) do
      request.headers.merge!(headers)
      get :index
    end

    it "responds with success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns @boards" do
      expect(assigns(:boards)).to eq([board])
    end

    it "renders the board index template" do
      expect(response).to render_template("v1/boards/index")
    end
  end

  #
  # Show
  #

  describe "GET show" do
    before(:each) do
      board.saved_boards << saveable_board
      request.headers.merge!(headers)
      get :show, params: { public_token: board.public_token }
    end

    it "responds with success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns @board" do
      expect(assigns(:board)).to eq(board)
    end

    it "renders the board show template" do
      expect(response).to render_template("v1/boards/show")
    end
  end
end
