class AuthenticateController < ApplicationController  

  def authenticate
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password])
      @user.token = generate_token(@user)
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    payload = { user_id: user.id, exp: 2.seconds.from_now.to_i }
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end
end
