# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  
  def new
    super
    flash[:notice] = "Para usar esta pagina debe Iniciar Sesion o Registrarse"
  end

  def create
    super do |resource|
    flash[:notice] = "¡Bienvenido de nuevo, #{resource.email}!"
    end
  end

  def destroy
    super do
    flash[:notice] = "Has cerrado sesión exitosamente."
    end
  end
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
