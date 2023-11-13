class OrderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "order"

    ActionCable.server.broadcast("order", { 
      rfid_identifier: 1, 
      write: false,
      read: true,
      timestamps: Time.now
    })
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
