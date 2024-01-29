class Users::RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters
    def create
        super do |resource|
        flash[:notice] = "¡Bienvenido, #{resource.email}!"
        end
    end
    
    def delete_account
        if current_user
            current_user.destroy # elimina cuenta del usuario actual
            sign_out current_user # cierra sesion del usuario actual
            flash[:notice] = "Has eliminado tu cuenta exitosamente."
            redirect_to root_path
        end
    end

    def show_profile
        @user = current_user
      end

    protected # Indica que todo lo que viene después será un método protegido. Los métodos protegidos son accesibles desde instancias de la clase y de sus subclases, pero no desde fuera.

    def configure_permitted_parameters #  interfaz para manipular parámetros de Devise. 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    end
end
