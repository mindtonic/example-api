require 'rails_helper'

RSpec.describe StatusController, type: :request do

  #
  # Index
  #

  describe "index" do
    it "responds with a happy status message" do
      get "/"
      expect(response).to render_template(:index)
      expect(response.status).to eq(200)
      expect(json["app"]).to eq("Example API")
      expect(json["status"]).to eq("Happy")
      expect(json["environment"]).to eq("test")
    end
  end
end
