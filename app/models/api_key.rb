class ApiKey < ActiveRecord::Base

  #
  # Validations
  #

  validates :key, presence: true, uniqueness: true
  validates :secret, presence: true, uniqueness: true
  validates :ip_address, presence: true

  #
  # Scopes
  #

  scope :active, ->{ where(active: true) }

  #
  # Callbacks
  #

  after_initialize :set_tokens

  def set_tokens
    self.key = SecureRandom.hex unless self.key.present?
    self.secret = SecureRandom.base64(160) unless self.secret.present?
  end

end
