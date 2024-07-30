class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update, :destroy]
  def index
    @users = User.all
    render json: UserSerializer.new(@users).serializable_hash.to_json
  end
  
  def show
    @user = User.find(params[:id])
    render json: UserSerializer.new(@user).serializable_hash.to_json
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json if @user
    else
      render json: ErrorSerializer.serialize(@user.errors).to_json
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render json: UserSerializer.new(@users).serializable_hash.to_json
    else
      render json: UserSerializer.new(@users).serializable_hash.to_json
    end
  end  
  
  def destroy
    @user = User.find(params[:id])
    if current_user?(@user)
      flash[:error] = "Admin users cannot destroy themselves."
    else
      @user.destroy
      flash[:success] = "User destroyed."
    end
    
    redirect_to users_path
  end
  
  private
    
  def user_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params, polymorphic: [:user])
  end
end