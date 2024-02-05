class Links::LinksController < ApplicationController
    before_action :authenticate_user!
    before_action :set_link, only: [:show, :edit, :update, :destroy]
    before_action :find_link, only: [:access_link, :authenticate_private_link]

  
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
      unless @link
        flash[:alert] = "El enlace no existe."
        redirect_to root_path
      end

      if @link.regular?
        @link.register_access(request.remote_ip)
        render 'links/show'
      elsif @link.private?
        render 'links/private_access', locals: { link: @link } 
      elsif @link.ephemeral?
        if @link.used
          render_error(:forbidden)
        else
          @link.register_access(request.remote_ip)
          @link.update(used: true)
          render 'links/show'
        end
      elsif @link.temporary?
        if not @link.expiration_date < Time.now
        @link.register_access(request.remote_ip)
        render 'links/show'
        else
          render_error(status :not_found)
        end
      else
        flash[:alert] = "Hubo un error al acceder al enlace."
        redirect_to root_path
      end
    end
  
    def authenticate_private_link
      @link = Link.find_by(slug: params[:slug])
      
      if @link.private? && params[:password] == @link.password
          @link.register_access(request.remote_ip)
          render 'links/show'
      else
        flash[:alert] = 'La contraseña es incorrecta. Ya no puede acceder al link privado.'
        redirect_to root_path
      end
    end    
    
    # para los reportes
    def access_details
      @link = Link.find_by(slug: params[:slug])
      @access_details = @link.access_details
      render 'links/access_details'
    end
  
    def access_count_by_day
      @link = Link.find_by(slug: params[:slug])
      @access_count_by_day = @link.access_count_by_day
      render 'links/access_count_by_day'
    end

    private

    def render_error(status)
      if status == :not_found
        render 'links/access_link', status: :not_found
      elsif status == :forbidden
        render 'links/forbidden', status: :forbidden
      else
        # Renderizar una vista de error genérica
        render 'error', status: status
      end
    end
    

    def set_link
      @link = current_user.links.find(params[:id])
    end
 
    def find_link
      @link = Link.find_by(slug: params[:slug])
      unless @link
        flash[:alert] = "El enlace no existe."
        redirect_to root_path
      end
    end
     
end