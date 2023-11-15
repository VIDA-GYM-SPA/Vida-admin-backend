class ClientsController < ApplicationController
  before_action :authorize_request
  before_action :set_client, only: %i[ show update destroy ]

  
  # GET /clients
  def index
    @allowed_roles = [1, 2]
    if @allowed_roles.include?(@current_user.role_id)
      @clients = User.where(role_id: 3)
      render json: @clients
    else 
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  # GET /clients/1
  def show
    render json: @client
  end

  # POST /clients
  def create
    @allowed_roles = [1, 2]
    @client = User.new(client_params)
    @client.role_id = 3

    if @allowed_roles.include?(@current_user.id) 
      if @client.save
        render json: @client, status: :created, location: @client
      else
        render json: @client.errors, status: :unprocessable_entity
      end
    else 
      render json: { error: 'Unauthorized' }, status: :unauthorized
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
    @allowed_roles = [1]
    if @allowed_roles.include?(@current_user.role_id)
      @client.destroy
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = User.where(id: params[:id], role_id: 3)[0]
    end

    # Only allow a list of trusted parameters through.
    def client_params
      params.(:client).permit(:name, :lastname, :email, :dni, :gender, :password, :password_confirmation)
    end
end
