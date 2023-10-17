class RfidController < ApplicationController
  def index
    if params [:user_id]
      @user = User.find(:user_id)
    end

    render json: {
      rfid_token: SecureRandom.hex(48),
      assign_to: @user.name || 'Nobody'
    }
  end
end
