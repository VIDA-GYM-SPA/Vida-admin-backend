class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def refresh_user_token(token)
    secret_key_base = Rails.application.secrets.secret_key_base.to_s
    JWT.decode(token, secret_key_base, true, { algorithm: 'HS256' })
  end
end
