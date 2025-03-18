require 'rails_helper'

RSpec.describe "Login", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    User.destroy_all # 💡 Borra todos los usuarios antes de la prueba
    @user = User.create!(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
  end

  it "permite a un usuario iniciar sesión con credenciales correctas" do
    visit new_user_session_path
  
    fill_in "user_email", with: "usuario1@example.com"
    fill_in "user_password", with: "password123"
    
    click_button "Iniciar Sesion"
  
    expect(page).to have_content("¡Bienvenido de nuevo, usuario1@example.com!") # ✅ 
  end  
end
