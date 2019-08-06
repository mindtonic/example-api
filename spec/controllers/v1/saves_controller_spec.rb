require "rails_helper"

RSpec.describe V1::SavesController do
  let(:api_key) { create(:api_key, ip_address: "0.0.0.0") }
  let(:board) { create(:board) }
  let(:saveable_board) { create(:board) }
  let(:headers) { {
    "ACCEPT" => "application/json",
    "X-Api-Key" => api_key.key,
    "X-Api-Secret" => api_key.secret
  } }

  #
  # Create
  #

  describe "POST create" do
    before(:each) do
      request.headers.merge!(headers)
      post :create, params: { public_token: board.public_token, saveable_token: saveable_board.public_token }
    end

    it "responds with success" do
      expect(response).to have_http_status(:success)
    end

    it "assigns @board" do
      expect(assigns(:board)).to eq(board)
    end

    it "assigns @saveable_board" do
      expect(assigns(:saveable_board)).to eq(saveable_board)
    end

    it "associates @saveable_board to @board" do
      expect(assigns(:board).saved_boards).to eq([saveable_board])
    end

    it "renders the board show template" do
      expect(response).to render_template("v1/boards/show")
    end
  end

  #
  # Destroy
  #

  describe "DELETE destroy" do
    before(:each) do
      board.saved_boards << saveable_board
      request.headers.merge!(headers)
    end

    context "the basic response" do
      before(:each) do
        delete :destroy, params: { public_token: board.public_token, saveable_token: saveable_board.public_token }
      end

      it "responds with success" do
        expect(response).to have_http_status(:success)
      end

      it "assigns @board" do
        expect(assigns(:board)).to eq(board)
      end

      it "assigns @saveable_board" do
        expect(assigns(:saveable_board)).to eq(saveable_board)
      end

      it "renders the board show template" do
        expect(response).to render_template("v1/boards/show")
      end
    end

    it "tests successful board removal" do
      expect(board.saved_boards).to eq([saveable_board])
      delete :destroy, params: { public_token: board.public_token, saveable_token: saveable_board.public_token }
      expect(assigns(:board).saved_boards).to eq([])
    end
  end
end
