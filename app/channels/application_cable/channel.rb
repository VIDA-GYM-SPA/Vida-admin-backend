module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_from "security_#{current_user.id}_channel"

      ActionCable.server.broadcast "security_#{current_user.id}_channel", { message: 'Hello World' }
    end

    def unsubscribed
    end
  end
end
