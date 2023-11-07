class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
    render json: @payments, status: :ok
  end

  def show
    render json: @payment, status: :ok
  end

  def create
    @payment = Payment.new(payment_params)
    if @current_user.role.name === 'admin'
      if @payment.save 
        render json: { message: "User created successfully", user: @payment }, status: :created
      else
        render json: { errors: @payment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end

  def edit
    
  end
end
