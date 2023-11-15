class PaymentsController < ApplicationController
  before_action :authorize_request

  def index
    @payments = Payment.all
    render json: @payments, status: :ok
  end

  def show
    render json: @payment, status: :ok
  end

  def create
    @payment = Payment.new(payment_params)
    @payment.user_id = @current_user.id
    if @payment.save 
      render json: { message: "User created successfully", user: @payment }, status: :created
    else
      render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    allowed_roles = [1, 2]

    if allowed_roles.include?(@current_user.role_id)
      if @payment.update(payment_params).save
        render json: { message: "User updated successfully", user: @payment }, status: :ok
      else
        render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
      end 
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end 

  def destroy
    allowed_roles = [1]

    if allowed_roles.include?(@current_user.role_id)
      if @payment.destroy
        render json: { message: "User deleted successfully" }, status: :ok
      else
        render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end

  private

  def set_payment
    @payment = Payment.find_by_id!(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :user_id, :money, :method, :payed_at, :reference, :bank, :phone, :dni)
  end
end
