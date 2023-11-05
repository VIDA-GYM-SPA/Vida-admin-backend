class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users-#{params[:user_id]}"
  end

  def unsubscribed
    stop_all_streams
  end

  def my_profile
    
  end
end
