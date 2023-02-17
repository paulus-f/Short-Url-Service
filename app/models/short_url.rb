class ShortUrl < ApplicationRecord
  MAX_SLUG_LENGTH = 10.freeze
  MIN_SLUG_LENGTH = 5.freeze

  MAX_URL_LENGTH = 500.freeze
  MIN_URL_LENGTH = 5.freeze

  DEFAULT_TIME_EXPIRATION = 30.days

  class << self
    def generate_slug
      SecureRandom.alphanumeric(MAX_SLUG_LENGTH)
    end
  end

  belongs_to :user

  validates :expired_at, presence: true

  validates :slug, presence: true, uniqueness: true
  validates :slug, length: { maximum: MAX_SLUG_LENGTH, too_long: "%{count} characters is the maximum allowed" }
  validates :slug, length: { minimum: MIN_SLUG_LENGTH, too_long: "%{count} characters is the minimum allowed" }

  validates :url, presence: true, format: URI::regexp(%w[http https])
  validates :url, length: { maximum: MAX_URL_LENGTH, too_long: "%{count} characters is the maximum allowed" }
  validates :url, length: { minimum: MIN_URL_LENGTH, too_long: "%{count} characters is the minimum allowed" }

  scope :active, -> { where('expired_at > ?', Time.now) }
end
