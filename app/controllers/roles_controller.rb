class RolesController < ApplicationController
  before_action :authorize_request
  before_action :set_role, only: %i[ show update destroy ]

  # GET /roles
  def index
    @roles = Role.all

    render json: @roles
  end

  # GET /roles/1
  def show
    render json: @role
  end

  # POST /roles
  def create
    allowed_roles = [1]
    @role = Role.new(role_params)
  
    if allowed_roles.include?(@current_user.role_id)
      if @role.save
        render json: @role, status: :created, location: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end

  # PATCH/PUT /roles/1
  def update
    allowed_roles = [1]
  
    if allowed_roles.include?(@current_user.role_id)
      if @role.update(role_params)
        render json: @role
      else
        render json: @role.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end

  # DELETE /roles/1
  def destroy
    allowed_roles = [1]
    @role = Role.new(role_params)
  
    if allowed_roles.include?(@current_user.role_id)
      @role.destroy
    else
      render json: { message: "Unauthorized" }, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_params
      params.fetch(:role, {:name})
    end
end
