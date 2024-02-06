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

end
