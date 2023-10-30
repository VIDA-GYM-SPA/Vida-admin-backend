# app/channels/user_status_channel.rb

class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_for current_user
  end

  def unsubscribed
    # Any cleanup needed when the user unsubscribes
  end
end
