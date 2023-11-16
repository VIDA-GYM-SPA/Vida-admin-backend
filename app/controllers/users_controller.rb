class UsersController < ApplicationController
  before_action :authorize_request
  def index
    @users = User.all
    render json: @current_user, status: :ok
  end

  def show
    @allowed_roles = [1, 2]
    if @allowed_roles.include?(@current_user.role_id)
      render json: @user, status: :ok
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    @user.status = 'suscribed'
    if @current_user.role.name === 'admin'
      if @user.save 
        Notification.create(title: "Action-Needed", description: 'A user has pending an action', user_with_pendings_actions: @user.id)
        ActionCable.server.broadcast("rfid", { 
          message: 'A user has pending an action', 
          type: "Action-Needed",
          user: @user,
          username_parser: "#{@user.name} #{@user.lastname}",
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
    if @current_user.role.name === 'admin'
      if @user.update(user_params).save
        render json: { message: "User updated successfully", user: @user }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end

  def edit_password
    if password_params[:password] == password_params[:password_confirmation]
      if BCrypt::Password.new(@current_user.password_digest) == password_params[:password]
        if @current_user.update(password_digest: password_params[:new_password])
          render json: { message: "Password updated successfully" }, status: :ok
        else
          render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { errors: 'Password does not match' }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Passwords do not match' }, status: :unprocessable_entity
    end
  end
  
  def destroy
    if @current_user.role.name === 'admin'
      if @user.destroy
        render json: { message: "User deleted successfully" }, status: :ok
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end

  def profile 
    render json: @current_user, status: :ok
  end
  
  private

  def find_user
    @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.require(:user).permit(:name, :lastname, :email, :dni, :gender, :permissions, :role_id, :password, :password_confirmation)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :new_password)
  end
end