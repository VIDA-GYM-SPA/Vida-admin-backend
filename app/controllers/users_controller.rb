class UsersController < ApplicationController
  before_action :authorize_request
  def index
    @users = User.all
    render json: @current_user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @current_user.role.name === 'admin'
      if @user.save 
        Notification.create(title: "Action-Needed", description: 'A user has pending an action', user_with_pendings_actions: @user.id)
        ActionCable.server.broadcast("rfid", { 
          message: 'A user has pending an action', 
          type: "Action-Needed",
          user: @user,
          block_system: true,
          action_description: "User needs to take actions:\n1. Add RFID band.\n2. Add fingerprint"
        })
        render json: { message: "User created successfully", user: @user }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end

  def edit
  end

  def destroy
  end
  
  private

  def find_user
    @user = User.find_by_id!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :dni, :gender, :permissions, :role_id, :password, :password_confirmation)
  end
end