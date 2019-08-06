require "rails_helper"

RSpec.describe "API V1 Saves", :type => :request do
  let(:api_key) { create(:api_key, ip_address: "127.0.0.1") }
  let!(:board) { create(:board) }
  let(:saveable_board) { create(:board) }
  let(:headers) { {
    "ACCEPT" => "application/json",
    "X-Api-Key" => api_key.key,
    "X-Api-Secret" => api_key.secret
  } }

  #
  # Create
  #

  describe "POST #create" do
    it_should_behave_like "an authenticated v1 POST request", "/v1/boards/:public_token/save/:saveable_token"

    context "with a valid saveable_board" do
      it "returns http 200 Success" do
        post "/v1/boards/#{board.public_token}/save/#{saveable_board.public_token}", params: {}, headers: headers

        expect(response).to have_http_status(200)
        expect(response.body).to include("name")
        expect(response.body).to include("public_token")
        expect(response.body).to include("description")
        expect(response.body).to include(board.public_token)
        expect(response.body).to include(saveable_board.public_token)
      end
    end

    context "with an invalid saveable_board" do
      it "returns http 404 Not Foud" do
        post "/v1/boards/#{board.public_token}/save/INVALID_TOKEN", params: {}, headers: headers

        expect(response).to have_http_status(404)
        expect(response.body).to include("error")
        expect(response.body).to include("Board Not Found")
      end
    end
  end

  #
  # Destroy
  #

  describe "DELETE #destroy" do
    it_should_behave_like "an authenticated v1 DELETE request", "/v1/boards/:public_token/save/:saveable_token"

    context "with a valid saveable_board" do
      it "returns http 200 Success" do
        board.saved_boards << saveable_board
        expect(board.saved_boards).to include(saveable_board)

        delete "/v1/boards/#{board.public_token}/save/#{saveable_board.public_token}", params: {}, headers: headers

        expect(response).to have_http_status(200)
        expect(response.body).to include("name")
        expect(response.body).to include("public_token")
        expect(response.body).to include("description")
        expect(response.body).to include(board.public_token)
        expect(response.body).not_to include(saveable_board.public_token)
      end
    end

    context "with an invalid saveable_board" do
      it "returns http 404 Not Foud" do
        delete "/v1/boards/#{board.public_token}/save/INVALID_TOKEN", params: {}, headers: headers

        expect(response).to have_http_status(404)
        expect(response.body).to include("error")
        expect(response.body).to include("Board Not Found")
      end
    end
  end
end
