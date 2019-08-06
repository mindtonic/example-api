RSpec.shared_examples "a public token" do |klass|

  #
  # Validations
  #

  it { should validate_presence_of(:public_token) }
  it { should validate_uniqueness_of(:public_token).ignoring_case_sensitivity }

  #
  # Scopes
  #

  describe "scopes" do
    it "has a by_token scope" do
      expect(klass).to respond_to(:by_token)
    end
  end

  #
  # Callbacks
  #

  describe "public_token generation" do
    it "assigns a token if one does not exist" do
      expect(klass.new.public_token).not_to be_nil
    end
  end

end
