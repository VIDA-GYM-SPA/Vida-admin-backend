# connection.rb
module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags 'ActionCable', current_user.email
    end

    private

    def find_verified_user
      token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2OTgxNTk3MDV9.hZ5BGT7t617Rk2tkGJqCxTH08m0Hbt1KCSguDkYAZZ8"
      logger.info "Token: #{token.inspect}"
      secret_key_base = Rails.application.secrets.secret_key_base.to_s
      logger.info "Secret Key Base: #{secret_key_base}"
      
      if token.nil?
        reject_unauthorized_connection
      end
      
      begin
        decoded_token = JWT.decode(token, secret_key_base, true, { algorithm: 'HS256' })
        user_id = decoded_token.first['user_id']
        current_user = User.find_by(id: user_id)
        
        if current_user
          current_user
        else
          reject_unauthorized_connection
        end
      rescue JWT::DecodeError => e
        logger.error "JWT Decode Error: #{e.message}"
        reject_unauthorized_connection
      end
    end    
  end
end
