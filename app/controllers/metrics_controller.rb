class MetricsController < ApplicationController
  def most_viewed
    render json: ShortUrl.most_viewed.map(&:metric_view), status: :ok
  end

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
    @short_url.metric_view.merge(metadata: @short_url.short_url_metrics.pluck(:body))
  end
end
