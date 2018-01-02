class UsersController < ApplicationController

  def index
    render json: User.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: 422
    end
  end

  def show
    @user = find_user
    if @user
      render json: @user
    else
      render plain: "Cannot find user", status: 404
    end
  end

  def update
    @user = find_user
    if @user
      if @user.update(user_params)
        render json: @user
      else
        render json: @user.errors.full_messages, status: 400
      end
    else
      render plain: "Cannot find user to update", status: 400
    end
  end

  def destroy
    @user = find_user
    if @user
      @user.destroy
      redirect_to users_url
    else
      render plain: "Cannot find user to delete", status: 404
    end
  end

  private

  def find_user
    User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
