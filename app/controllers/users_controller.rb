class UsersController < ApplicationController

  def index
    @users = User.all
    render_json: UserSerializer.new(@users).serializable_hash.to_json
  end
  
  def show
    @user = User.find(params[:id])
    render_json: UserSerializer.new(@user).serializable_hash.to_json
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      @title = "Sign Up"
      @user.password = ""
      @user.password_confirmation = ""
      render 'new'
    end

    render_json: UserSerializer.new(@user).serializable_hash.to_json if @user
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      render_json: UserSerializer.new(@users).serializable_hash.to_json
    else
      render_json: UserSerializer.new(@users).serializable_hash.to_json
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
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
    
    def guest_user
      redirect_to(root_path) if signed_in?
    end
end