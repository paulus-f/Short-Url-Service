class UsersController < ApplicationController
  before_action :authorize_request, except: :create
  before_action :find_user, only: %i[show update destroy]

  def index
    render json: collection
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def collection
    @collection ||= User.all
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
