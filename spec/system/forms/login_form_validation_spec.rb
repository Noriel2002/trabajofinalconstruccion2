require 'rails_helper'

RSpec.describe "Validación de formulario de inicio de sesión", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # Limpiar sesiones previas
    Capybara.reset_sessions!
  end

  it "muestra mensajes de error cuando se envía el formulario vacío" do
    # Visitar la página de login
    visit new_user_session_path

    # Intentar iniciar sesión sin completar los campos
    click_button "Iniciar Sesion"

    # Verificar que aparecen los mensajes de error adecuados
    expect(page).to have_content("Usuario o contraseña incorrectos")
  end
end
