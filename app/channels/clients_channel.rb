class ClientsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "clients"

    @clients = User.where(role: 3).to_json

    ActionCable.server.broadcast('clients', @clients)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
