module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def subscribed
      stream_from "security_#{current_user.id}_channel"

      # No envíes mensajes aquí, en lugar de eso, puedes hacerlo desde el cliente.
    end

    def unsubscribed
      # Aquí puedes agregar lógica para manejar la desconexión del usuario si es necesario.
    end
  end
end
