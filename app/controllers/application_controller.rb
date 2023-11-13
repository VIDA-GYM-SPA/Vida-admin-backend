class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def write_order
    ActionCable.server.broadcast("order", { 
      rfid_identifier: 1, 
      write: true,
      read: false,
      timestamps: Time.now
    })
  end

  def require_admin
    if @current_user.role.name === 'admin'
      yield
    else
      render json: { errors: 'Not authorized' }, status: :unauthorized
    end
  end
end
