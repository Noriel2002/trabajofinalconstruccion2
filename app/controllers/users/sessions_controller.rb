class Users::SessionsController < Devise::SessionsController

  def new
    super
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
