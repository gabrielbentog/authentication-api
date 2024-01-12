class Api::V1::UsersController < ApplicationController
  before_action :authenticate_api_v1_user!, except: [:create]

  # GET api/v1/users
  def index
    @users = User.all

    render json: UserSerializer.new(@users).serializable_hash.to_json
  end

  # GET api/v1/users/1
  def show
    render json: UserSerializer.new(@user).serializable_hash.to_json
  end

  # POST api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: :created
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # PATCH/PUT api/v1/users/1
  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash.to_json
    else
      render json: ErrorSerializer.serialize(@user.errors), status: :unprocessable_entity
    end
  end

  # DELETE api/v1/users/1
  def destroy
    @user.destroy
  end

  private

  # Only allow a trusted parameter "white list" through.
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:user])
  end
end
