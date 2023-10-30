module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_from "security_#{current_user.id}_channel"

      # Broadcast data to the channel.
      ActionCable.server.broadcast("security_#{user.id}_channel", content: "New data to send")

      ActionCable.server.broadcast("SecurityChannel", content: "New data to send")

      # No envíes mensajes aquí, en lugar de eso, puedes hacerlo desde el cliente.
    end

    def unsubscribed
      # Aquí puedes agregar lógica para manejar la desconexión del usuario si es necesario.
    end
  end
end
