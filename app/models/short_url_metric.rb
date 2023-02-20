class ShortUrlMetric < ApplicationRecord
  validates :short_url, presence: true

  belongs_to :short_url
end
