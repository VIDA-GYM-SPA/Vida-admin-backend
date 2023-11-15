class ClientsController < ApplicationController
  before_action :authorize_request
  before_action :set_client, only: %i[ show update destroy ]

  allowed_roles = [1, 2]

  # GET /clients
  def index
    if allowed_roles.includes(@current_user.role_id) {
      @clients = User.where(role_id: 3)
      render json: @clients
    } else {
      render json: { error: 'Unauthorized' }, status: :unauthorized
    }
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @client = User.new(client_params)

    if @client.save
      render json: @client, status: :created, location: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      render json: @client
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.fetch(:client, {})
    end
end
