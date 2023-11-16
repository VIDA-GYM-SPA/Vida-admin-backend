class ExchangesController < ApplicationController
  before_action :authorize_request
  before_action :set_exchange, only: %i[ show update destroy ]

  # GET /exchanges
  def index
    @exchanges = Exchange.last

    render json: @exchanges
  end

  # GET /exchanges/1
  def show
    render json: @exchange
  end

  # POST /exchanges
  def create
    allowed_roles = [1]
    if allowed_roles.include?(@current_user.role_id)
      @exchange = Exchange.new(exchange_params)

      if @exchange.save
        render json: @exchange, status: :created, location: @exchange
      else
        render json: @exchange.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # PATCH/PUT /exchanges/1
  def update
    allowed_roles = [1]
    if allowed_roles.include?(@current_user.role_id)
      if @exchange.update(exchange_params)
        render json: @exchange
      else
        render json: @exchange.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # DELETE /exchanges/1
  def destroy
    allowed_roles = [1]
    if allowed_roles.include?(@current_user.role_id)
      @exchange.destroy
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange
      @exchange = Exchange.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def exchange_params
      params.require(:exchange).permit(:dolar)
    end
end
