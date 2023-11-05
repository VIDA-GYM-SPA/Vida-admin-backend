class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 7.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end

  def self.refresh_user_token(token, email)
    time = Time.now + 7.days.to_i
    user = nil
    if User.find_by_email(email) != nil
      user = User.find_by_email(email)
      new_token_generated = JsonWebToken.encode(user_id: user.id)
      
      @result = { 
        token: new_token_generated,
        exp: time.strftime("%m-%d-%Y %H:%M"),
        user: user
      }
  
      begin 
        JsonWebToken.decode(token)
      rescue JWT::DecodeError
        return {
          error: "Error with token provided"
        }
      rescue JWT::ExpiredSignature
        return @result
      else
        return @result
      end
    else
      return {
        error: "User not found"
      }
    end
  end
end
