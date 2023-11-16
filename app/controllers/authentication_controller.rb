class AuthenticationController < ApplicationController 
  before_action :authorize_request 
   # POST /login
   def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 7.days.to_i
      render json: { token: token, 
                     exp: time.strftime("%m-%d-%Y %H:%M"),
                     user: @user
                   }, status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
