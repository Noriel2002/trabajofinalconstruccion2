class Link < ApplicationRecord
    self.inheritance_column = :_disabled

    has_many :accesses, dependent: :destroy # accesos 

    belongs_to :user
    before_create :generate_slug, :generate_unique_url
  
    validates :slug, presence: true, uniqueness: true
    validates :link_type, inclusion: { in: %w[temporary private regular ephemeral] }
    # Para enlaces temporales
    validates :expiration_date, presence: true, if: :temporary?
    validate :expiration_date_cannot_be_in_the_past, if: :temporary?
    # Para enlaces privados
    validates :password, presence: true,  if: :private?
    validates :url, format: { with: URI::regexp(%w[http https]), message: "debe ser una URL válida" }, allow_blank: true
    validate :valid_url?

   # private
  
    def generate_slug
      self.slug = SecureRandom.hex(3)
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

    # creo q no lo uso 
    def expiration_date_cannot_be_in_the_past
      errors.add(:expiration_date, "can't be in the past") if expiration_date.present? && expiration_date < Date.today
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
end
  