class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]
  before_action :only_my_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account successfully created"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit(:email, :password, :password_confirmation))
      redirect_to root_path , notice: "Your settings were successfully updated."
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find_by(username: params[:username])
    @user.destroy
    redirect_to root_path, notice: "Account successfully closed."
  end

  private
    def find_user
      @user = User.find_by(username: params[:username])
    end

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :account_level)
    end

    def only_my_user
      redirect_to root_path, notice: "You cannot modify others' accounts" if current_user != @user
    end
end
