class PaymentsController < ApplicationController
  def index
    @payments = Payment.all
    render json: @payments, status: :ok
  end
end
