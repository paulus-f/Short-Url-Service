class ShortUrl < ApplicationRecord
  MAX_SLUG_LENGTH = 10
  MIN_SLUG_LENGTH = 5

  MAX_URL_LENGTH = 500
  MIN_URL_LENGTH = 5

  DEFAULT_TIME_EXPIRATION = 30.days

  class << self
    def generate_slug
      SecureRandom.alphanumeric(MAX_SLUG_LENGTH)
    end
  end

  belongs_to :user
  has_many :short_url_metrics

  validates :expired_at, presence: true

  validates :slug, presence: true, uniqueness: true
  validates :slug, length: { maximum: MAX_SLUG_LENGTH, too_long: '%<count>s characters is the maximum allowed' }
  validates :slug, length: { minimum: MIN_SLUG_LENGTH, too_long: '%<count>s characters is the minimum allowed' }

  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])
  validates :url, length: { maximum: MAX_URL_LENGTH, too_long: '%<count>s characters is the maximum allowed' }
  validates :url, length: { minimum: MIN_URL_LENGTH, too_long: '%<count>s characters is the minimum allowed' }

  scope :active, -> { where('expired_at > ?', Time.now) }
  scope :most_viewed, lambda { |n = 5|
    select('short_urls.*, COUNT(short_url_metrics.id) AS views')
      .joins(:short_url_metrics)
      .group('short_urls.id')
      .order('views DESC')
      .limit(n)
  }

  def metric_view
    {
      url: url,
      slug: slug,
      view: views
    }
  end

  def views
    short_url_metrics.count
  end
end
