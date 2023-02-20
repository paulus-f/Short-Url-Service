class ShortUrlsController < ApplicationController
  before_action :authorize_request, except: :show
  before_action :find_short_url, only: :destroy

  def index
    render json: current_user.short_urls.active
  end

  def show
    service = ShortUrls::ShowUrl.new(metric_params, params[:slug])

    if service.call
      redirect_to service.url, allow_other_host: true
    else
      render json: { errors: 'The url is not active' }, status: 400
    end
  end

  def create
    @service = ShortUrls::Create.new(urls_params, current_user)

    if @service.call
      render json: @service.url, status: :created
    else
      render json: { errors: @service.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @short_url.destroy

    head :no_content
  end

  private

  def find_short_url
    @short_url = ShortUrl.find(params[:id])
  end

  def urls_params
    params.require(:short_url).permit(:url, :slug, :expired_at)
  end

  def metric_params
    user_agent = UserAgent.parse(request.user_agent)

    {
      browser: user_agent.browser,
      os: user_agent.os,
      version: user_agent.version,
      platform: user_agent.platform,
      mobile: user_agent.mobile?,
      remote_ip: request.remote_ip
    }
  end
end
