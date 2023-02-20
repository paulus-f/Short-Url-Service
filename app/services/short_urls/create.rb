module ShortUrls
  class Create
    attr_reader :params, :user, :url

    def initialize(params, user)
      @params = params
      @user = user
    end

    def call
      @url = ShortUrl.new(short_urls_params)

      @url.save
    end

    def errors
      @url&.errors&.full_messages&.join(', ')
    end

    private

    def short_urls_params
      {
        slug: not_custom_slug? ? ShortUrl.generate_slug : params[:slug],
        url: params[:url],
        expired_at: params[:expired_at] || Time.now + ShortUrl::DEFAULT_TIME_EXPIRATION,
        user_id: user.id
      }
    end

    def not_custom_slug?
      params[:slug].blank?
    end
  end
end
