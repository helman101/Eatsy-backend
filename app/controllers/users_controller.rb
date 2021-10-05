class UsersController < ApplicationController
  def index
    @users = User.all
    if @users
      render json: {
        users: @users
      }
    else
      render json: {
        status: 500,
        errors: ['no users found']
      }
    end
  end

  def show
    begin 
      @user = User.find(params[:id])
    rescue
      render json: {
        errors: ['user not found']
      },
      status: :not_found
    else
      render json: {
        user: @user
      }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: {
        user: @user
      },
      status: :created
    else
      render json: {
        errors: @user.errors.full_messages
      },
      status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.authenticate(user_params['password'])
        render json: {
          user: { id: @user.id, name: @user.name, email: @user.email }
        }
      else
        render json: {
          errors: ['Wrong Password']
        }
      end
    else
      render json: {
        errors: ['User doesn\'t exist']
      }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end