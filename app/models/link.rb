class Link < ApplicationRecord
    self.inheritance_column = :_disabled

    has_many :accesses, dependent: :destroy # accesos 

    belongs_to :user
    before_create :generate_slug, :generate_unique_url
  
    validates :slug, presence: true, uniqueness: true
    validates :link_type, inclusion: { in: %w[temporary private regular ephemeral] }
    validate :valid_url?
    # Para enlaces temporales
    validates :expiration_date, presence: true, if: :temporary?
    # Para enlaces privados
    validates :password, presence: true,  if: :private?
   
    def generate_slug
      self.slug = SecureRandom.hex(2)
     end
  
    def generate_unique_url
      self.url_short =  "#{MiProyectoRuby::Application::DOMAIN}/l/#{self.slug}"
    end

    def temporary?
      link_type == 'temporary'
    end
  
    def private?
      link_type == 'private'
    end
    
    def ephemeral?
      link_type == 'ephemeral'
    end

    def regular?
      link_type == 'regular'
    end

    def valid_url?
      return false if self.url.blank?
  
      uri = URI.parse(self.url)
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError
      false
    end

    def register_access(ip_address)
      accesses.create(ip_address: ip_address)
    end

    # para los reportes
    def access_details
      Access.where(link_id: id)
    end
  
    def access_count_by_day
      Access.where(link_id: id).group("DATE(created_at)").count
    end
    
    # intentos de accesos para link privado 
    def failed_access_attempt!
      update(access_attempted: true)
    end
  
end
  