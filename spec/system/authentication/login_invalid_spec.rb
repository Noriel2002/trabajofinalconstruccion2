require 'rails_helper'

RSpec.describe "Login", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    User.destroy_all  # 💡 Borra todos los usuarios antes de la prueba
    User.create!(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
  end

  it "no permite iniciar sesión con credenciales incorrectas" do
    visit new_user_session_path  # Ir a la página de login

    fill_in "Correo electronico", with: "usuario1@example.com"
    fill_in "Contraseña", with: "wrongpassword"  # Contraseña incorrecta
    click_button "Iniciar Sesion"

    expect(page).to have_content("Usuario o contraseña incorrecto")  # Ajusta el mensaje según tu app
  end
end
