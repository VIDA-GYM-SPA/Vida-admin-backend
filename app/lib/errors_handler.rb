class ErrorsHandler
  def self.handle_token(token = nil)
    

    raise "You must provide a token" if token == nil
    # raise "Token is invalidad" if JWT.decode
  end
end 