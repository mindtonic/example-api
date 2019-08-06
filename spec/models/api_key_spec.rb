require 'rails_helper'

RSpec.describe ApiKey, type: :model do

  #
  # Validations
  #

  it { should validate_presence_of(:key) }
  it { should validate_uniqueness_of(:key) }
  it { should validate_presence_of(:secret) }
  it { should validate_uniqueness_of(:secret) }
  it { should validate_presence_of(:ip_address) }

  #
  # Callbacks
  #

  context "callbacks" do
    describe "set_tokens" do
      it "generates the key and secret on initialization of a new ApiKey" do
        expect(ApiKey.new.key).not_to be_nil
        expect(ApiKey.new.secret).not_to be_nil
      end
    end
  end
end
