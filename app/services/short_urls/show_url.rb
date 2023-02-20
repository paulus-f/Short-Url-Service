module ShortUrls
  class ShowUrl
    attr_reader :body, :short_url, :slug

    def initialize(body, slug)
      @body = body
      @slug = slug
    end

    def call
      @short_url = ShortUrl.active.find_by_slug(slug)
      metric = ShortUrlMetric.new(short_urls_params)

      metric.save
    end

    def url
      short_url&.url
    end

    private

    def short_urls_params
      {
        body: @body,
        short_url: @short_url
      }
    end
  end
end
