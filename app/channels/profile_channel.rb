class ProfileChannel < ApplicationCable::Channel
  def subscribed
    stream_from "profile_1_channel"
  end

  def unsubscribed; end
end
