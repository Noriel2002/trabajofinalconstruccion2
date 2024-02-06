class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }, format: { with: /\A[a-z0-9_]+\z/, message: "solo permite letras minúsculas, números y guiones bajos" }
  
  has_many :links, dependent: :destroy

end
