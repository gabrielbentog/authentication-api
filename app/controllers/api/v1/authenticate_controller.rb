class Api::V1::AuthenticateController < ApplicationController  

  def authenticate
    @user = User.find_by(email: params[:email])
    if @user && @user.valid_password?(params[:password])
      token =  @user.create_new_auth_token
      @user.token = token["Authorization"] if token      
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
