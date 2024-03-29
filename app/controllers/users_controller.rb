class UsersController < ApplicationController

  before_filter :signed_in_user,         only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,           only: [:edit, :update]
  before_filter :admin_user,             only: :destroy
  before_filter :invalid_signin_actions, only: [:new, :create]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      flash[:error] = 'Sign up to the Sample App failed.'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = 'Profile updated'
      sign_in @user
      redirect_to @user
    else
      flash[:error] = 'Unable to update user settings.'
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

    def invalid_signin_actions
      if signed_in?
        redirect_to root_url, notice: 'Invalid action for signed in user'
      end
    end

end
