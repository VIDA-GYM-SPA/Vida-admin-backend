class PaymentsController < ApplicationController
  def index
    # ["id", "reason", "amount", "payed_at", "user_id", "is_accepted", "discount", "created_at", "updated_at"] 
    @payments = Payment.all
    render json: @payments, status: :ok
  end
end
