module RfidManager
  def self.change_rfid_to_pending
    @notification = Notification.last
    @user = User.find(@notification.user_with_pendings_actions)
    @notification.update(is_pending: true)
    ActionCable.server.broadcast("rfid", {
      message: 'A user has pending an action',
      type: "Action-Needed",
      block_system: true,
      user: @notification.user_with_pendings_actions,
      username_parser: "#{@user.name} #{@user.lastname}",
      action_description: "User needs to take actions:\n1. Add RFID band.\n2. Add fingerprint",
      timestamps: Time.now
    })
  end

  def self.change_rfid_to_ok
    @notification = Notification.last
    @user = User.find(@notification.user_with_pendings_actions)
    @notification.update(is_pending: false)
    ActionCable.server.broadcast("rfid", { 
      message: nil, 
      type: "OK",
      block_system: false,
      user: @notification.user_with_pendings_actions,
      username_parser: "#{@user.name} #{@user.lastname}",
      action_description: "Nothing to do...",
      timestamps: Time.now
    })
  end
end
