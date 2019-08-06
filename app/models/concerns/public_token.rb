require 'active_support/concern'

module PublicToken
  extend ActiveSupport::Concern

  included do

    #
    # Validations
    #

    validates :public_token, presence: true, uniqueness: {case_sensitive: false}

    #
    # Scopes
    #

    scope :by_token, -> token { where(public_token: token) }

    #
    # Callbacks
    #

    after_initialize :set_public_token

    def set_public_token
      unless self.public_token
        self.public_token = SecureRandom.uuid
      end
    end
  end
end
