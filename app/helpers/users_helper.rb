module UsersHelper
    def welcome_message
        if user_signed_in?
          "¡Hola, #{current_user.email}!"
        else
          "Bienvenido, invitado."
        end
      end


end
