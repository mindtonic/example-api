require "rails_helper"

RSpec.describe "API V1 Boards", :type => :request do
  let(:api_key) { create(:api_key, ip_address: "127.0.0.1") }
  let!(:board) { create(:board) }
  let(:headers) { {
    "ACCEPT" => "application/json",
    "X-Api-Key" => api_key.key,
    "X-Api-Secret" => api_key.secret
  } }

  #
  # Index
  #

  describe "GET #index" do
    it_should_behave_like "an authenticated v1 GET request", "/v1/boards"

    it "returns the pagination fields" do
      get "/v1/boards", params: {}, headers: headers

      [:limit_value, :total_pages, :current_page, :next_page, :prev_page,
       :first_page?, :last_page?, :out_of_range?, :pagination].each do |attr|
         expect(response.body).to include(attr.to_s)
      end
    end

    it "returns http 200 Success" do
      get "/v1/boards", params: {}, headers: headers

      expect(response).to have_http_status(200)
      expect(response.body).to include("name")
      expect(response.body).to include("public_token")
      expect(response.body).to include("description")
    end
  end

  #
  # Show
  #

  describe "GET #show" do
    it_should_behave_like "an authenticated v1 GET request", "/v1/boards/:public_token"

    it "returns http 200 Success" do
      get "/v1/boards/#{board.public_token}", params: {}, headers: headers

      expect(response).to have_http_status(200)
      expect(response.body).to include("name")
      expect(response.body).to include("public_token")
      expect(response.body).to include("description")
    end
  end
end
