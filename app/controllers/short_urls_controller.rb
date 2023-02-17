class ShortUrlsController < ApplicationController
  before_action :authorize_request, except: :show
  before_action :find_short_url, only: :destroy

  def index
    render json: current_user.short_urls.active
  end

  def show
    @short_url = ShortUrl.active.find_by_slug(params[:slug])

    redirect_to @short_url.url, allow_other_host: true
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
end
