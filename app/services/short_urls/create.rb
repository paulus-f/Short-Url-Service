module ShortUrls
  class Create

    attr_reader :short_url_params, :user, :url

    def initialize(params, user)
      @short_url_params = params
      @user = user
    end

    def call
      @url = ShortUrl.new(short_url_params)
      @url.slug = ShortUrl.generate_slug if is_not_custom_slug?
      @url.user = user

      @url.save
    end

    def errors
      @url&.errors.full_messages.join(', ')
    end

    private

    def is_not_custom_slug?
      short_url_params[:slug].blank?
    end
  end
end