class Links::LinksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link, only: [:show, :edit, :update, :destroy]
  
    def index
      @links = current_user.links
      render 'links/index' # Renderizar la vista index.html.erb
    end
  
    def new
      @link = current_user.links.build
      render 'links/new' # Renderizar la vista new.html.erb
    end
  
     def create
      @link = current_user.links.build(link_params)
      @link.generate_slug
      if  @link.valid_url?
        if @link.save
          flash[:notice] = "El enlace se creó correctamente."
          redirect_to root_path
        else
          flash[:alert] = "Hubo un error al crear el enlace."
          redirect_to root_path
        end
      else
        flash[:alert] = "La URL ingresada no es válida. Por favor, ingresa una URL válida."
        redirect_to root_path
      end
    end
   

    def link_params
        params.require(:link).permit(:name, :url, :link_type, :expiration_date, :password, :slug)
    end
  
    def edit
      @link = Link.find(params[:id])
      render 'links/edit'
    end
  
    def update # ver si utilizo esta funcion sino borrarla
      @link = Link.find(params[:id])
      if @link.update(link_params)
        flash[:notice] = "El enlace se actualizó correctamente."
        redirect_to root_path 
      else
        flash[:alert] = "Hubo un error al actualizar el enlace."
        redirect_to root_path 
      end
    end

    def destroy
      @link = Link.find(params[:id])
      if @link.destroy
        flash[:notice] = "El enlace se eliminó correctamente."
      else
        flash[:alert] = "Hubo un error al eliminar el enlace."
      end
      redirect_to root_path
    end

    def show
      @link = current_user.links.find(params[:id])
    end        

    def access_link
      @link = Link.find_by(slug: params[:slug])
      return render_404 unless @link
  
      if @link.regular? || @link.temporary?
        # Registrar acceso al enlace
        @link.register_access(request.remote_ip)
        # Redirigir al usuario a la URL de destino
        redirect_to @link.url
      elsif @link.private?
        # Si el enlace es privado, mostrar página de solicitud de clave
        render 'links/private_access'
      elsif @link.ephemeral?
        # Si el enlace es efímero, devolver código 403 Forbidden
        render plain: "Acceso prohibido", status: :forbidden
      end
    end
  
    private
  
    # Método para manejar solicitudes de enlaces que no existen
    def render_404
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end

    def set_link
      @link = current_user.links.find(params[:id])
    end
     
end