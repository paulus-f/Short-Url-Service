class AuthController < ApplicationController
  before_action :authorize_request, except: :login
  before_action :find_user, only: :login

  def login
    @user.authenticate(login_params[:password])

    render json: login_response, status: :ok
  end

  private

  def find_user
    @user = User.find_by(email: login_params[:email])

    render json: { error: 'User is not found' }, status: :record_not_found if @user.nil?
  end

  def login_params
    params.permit(:email, :password)
  end

  def login_response
    token = ::JsonWebTokenTool.encode(user_id: @user.id)
    time = Time.now + 24.hours

    {
      token: token,
      exp: time.strftime("%m-%d-%Y %H:%M"),
      user_id: @user.id,
      email: @user.email
    }
  end
end
