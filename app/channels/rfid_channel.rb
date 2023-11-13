class RfidChannel < ApplicationCable::Channel
  def subscribed
    stream_from "rfid"
    @notification = Notification.last 
    return unless @notification

    @user = User.find(@notification.user_with_pendings_actions)

    if @notification.is_pending
      ActionCable.server.broadcast("rfid", { 
        message: 'A user has pending an action', 
        type: "Action-Needed",
        user: @notification.user_with_pendings_actions,
        username_parser: "#{@user.name} #{@user.lastname}",
        block_system: true,
        action_description: "User needs to take actions:\n1. Add RFID band.\n2. Add fingerprint",
        timestamps: Time.now
      })
    else
      ActionCable.server.broadcast("rfid", { 
        message: nil, 
        type: "OK",
        user: @notification.user_with_pendings_actions,
        username_parser: nil,
        block_system: false,
        action_description: "Nothing to do...",
        timestamps: Time.now
      })
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def rfid_status
    ActionCable.server.broadcast("rfid", { message: "hello world" })
  end
end
