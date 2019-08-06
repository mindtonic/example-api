require "rails_helper"

##
# This example group will test all the ways that a given route should fail without
# the proper credentials. A successful route should be tested in the request spec
# where context is relevant.
#
RSpec.shared_examples "an authenticated v1 GET request" do |action|
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:api_key) { create(:api_key, ip_address: "127.0.0.1") }

  describe "route: #{action}" do
    context "with a valid API Token and an invalid IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => api_key.key,
          "X-Api-Secret" => api_key.secret
        })
        get action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and a valid IP Address" do
      it "returns http 401 Unauthorized" do
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        get action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        get action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "without an API Token" do
      it "returns http 401 Unauthorized" do
        get action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end
  end
end

#
# Post
#

RSpec.shared_examples "an authenticated v1 POST request" do |action|
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:api_key) { create(:api_key, ip_address: "127.0.0.1") }

  describe "route: #{action}" do
    context "with a valid API Token and an invalid IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => api_key.key,
          "X-Api-Secret" => api_key.secret
        })
        post action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and a valid IP Address" do
      it "returns http 401 Unauthorized" do
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        post action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        post action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "without an API Token" do
      it "returns http 401 Unauthorized" do
        post action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end
  end
end

#
# Delete
#

RSpec.shared_examples "an authenticated v1 DELETE request" do |action|
  let(:headers) { { "ACCEPT" => "application/json" } }
  let(:api_key) { create(:api_key, ip_address: "127.0.0.1") }

  describe "route: #{action}" do
    context "with a valid API Token and an invalid IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => api_key.key,
          "X-Api-Secret" => api_key.secret
        })
        delete  action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and a valid IP Address" do
      it "returns http 401 Unauthorized" do
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        delete  action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "with an invalid API Token and IP Address" do
      it "returns http 401 Unauthorized" do
        api_key.update_attribute(:ip_address, "192.168.0.1")
        headers.merge!({
          "X-Api-Key" => SecureRandom.hex,
          "X-Api-Secret" => SecureRandom.base64(160)
        })
        delete  action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end

    context "without an API Token" do
      it "returns http 401 Unauthorized" do
        delete  action, params: {}, headers: headers
        expect(response).to have_http_status(401)
        expect(response.body).to include("Not Authorized")
      end
    end
  end
end
