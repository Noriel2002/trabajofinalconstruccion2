class Links::LinksController < ApplicationController
    before_action :authenticate_user!, except: [:public_index, :access_link, :update, :authenticate_private_link]
    before_action :set_link, only: [:show, :edit, :update, :destroy]

    def index
      set_links
      render 'links/index'
    end
  
    def public_index
      set_links
      render 'links/public_index'
    end
  
    def new
      flash.clear
      @link = current_user.links.build
      render 'links/new'
    end
  
    def create
      flash.clear
      @link = current_user.links.build(link_params)
      @link.generate_slug
      if  @link.valid_url?
        if @link.save
          flash[:notice] = "El enlace se creó correctamente."
        else
          flash[:alert] = "Hubo un error al crear el enlace."
        end 
        redirect_to root_path
      else
        flash[:alert] = "La URL ingresada no es válida. Por favor, ingresa una URL válida."
        render 'links/new'
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
        flash[:alert] = "Hubo un error al actualizar el enlace. Faltan datos."
        render 'links/edit'
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
      flash.clear
      @link = Link.find_by(slug: params[:slug])
      
      unless @link
        flash[:alert] = "El enlace no existe."
        redirect_to root_path
        return
      end
    
      case @link.link_type
      when "regular"
        @link.register_access(request.remote_ip)
        redirect_to @link.url, allow_other_host: true
      when "private"
        render 'links/private_access', locals: { link: @link }
      when "ephemeral"
        if @link.used
          render_error(:forbidden)
        else
          @link.register_access(request.remote_ip)
          @link.update(used: true)
          redirect_to @link.url, allow_other_host: true
        end
      when "temporary"
        if @link.expiration_date >= Time.now
          @link.register_access(request.remote_ip)
          redirect_to @link.url, allow_other_host: true
        else
          render_error(:not_found)
        end
      else
        render_error(:bad_request)
      end
    end
    
  
    def authenticate_private_link
      flash.clear
      @link = Link.find_by(slug: params[:slug])
      @links = Link.all
      
      if params[:password] == @link.password
          if @link.access_attempted
            flash[:alert] = "Se ha excedido el número de intentos de acceso. Este enlace ha sido bloqueado."
            render 'links/public_index'
          else
          @link.register_access(request.remote_ip)
          redirect_to @link.url, allow_other_host: true
          end
      else
        flash[:alert] = 'La contraseña es incorrecta. Ya no puede acceder al link privado.'
        @link.failed_access_attempt! unless @link.nil?
      render 'links/public_index'
      end
    end    
    
    # para los reportes
    def access_count_by_day
      flash.clear
      @link = Link.find_by(slug: params[:slug])
      @access_count_by_day = @link.access_count_by_day
      render 'links/access_count_by_day'
    end
    
    def access_details
      flash.clear 
      @link = Link.find_by(slug: params[:slug])
      @access_details = @link.access_details
      apply_ip_filter
      apply_date_range_filter
      set_flash_messages
      render 'links/access_details'
    end
    
    private

    # búsqueda de coincidencias parciales en la base de datos utilizando el operador LIKE de SQL.
    def apply_ip_filter
      return unless params[:ip_address].present?
    
      if params[:ip_address].present?
        ip_fragment = "%#{params[:ip_address]}%"
        @access_details = @access_details.where("ip_address LIKE ?", ip_fragment)
      end
    end
    
    def apply_date_range_filter
      if params[:start_date].present? && params[:end_date].present?
        start_date = Date.parse(params[:start_date])
        end_date = Date.parse(params[:end_date])
        @access_details = @access_details.where(created_at: start_date.beginning_of_day..end_date.end_of_day) # metodos de Rails
      end
    end
    
    def set_flash_messages 
      if @access_details.empty?
        flash[:alert] = 'No se encontraron resultados.'
      else
        flash[:notice] = 'Resultados para busqueda por ip' if params[:ip_address].present?
        flash[:notice] = 'Resultados para busqueda por fecha' if params[:start_date].present? && params[:end_date].present? && !@access_details.empty?
      end
    end    

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
 
    def set_links
      if user_signed_in?
        @links = current_user.links
      else
        @links = Link.all
      end
    end
     
end