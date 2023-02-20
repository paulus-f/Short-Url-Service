class MetricsController < ApplicationController
  def show
    @short_url = ShortUrl.find_by_slug(params[:slug])

    if @short_url
      render json: metric_response, status: :ok
    else
      render json: { errors: 'The url is not active' }, status: :bad_request
    end
  end

  private

  def metric_response
    {
      slug: @short_url.slug,
      metadata: @short_url.short_url_metrics.pluck(:body),
      views: @short_url.short_url_metrics.count
    }
  end
end
