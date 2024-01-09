class Api::V1::AuthenticateController < ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  def authenticate_user
    email = params[:email]
    password = params[:password]

    @user = User.find_for_database_authentication(email: email)


    if @user && @user.valid_password?(password)
      sign_in(:user, @user)
      token = @user.create_new_auth_token

      @user.auth_token = token["Authorization"]
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      @user.errors.add(:base, 'Invalid credentials') if @user.errors.size == 0
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end
end
