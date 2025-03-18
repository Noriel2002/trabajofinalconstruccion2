require 'rails_helper'

RSpec.describe "Logout", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    User.destroy_all # Elimina usuarios previos
    @user = User.create!(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
  end

  it "permite a un usuario cerrar sesión correctamente" do
    # Iniciar sesión
    visit new_user_session_path
    fill_in "user_email", with: "usuario1@example.com"
    fill_in "user_password", with: "password123"
    click_button "Iniciar Sesion"

    # Verificar que la sesión se haya iniciado correctamente
    expect(page).to have_content("¡Bienvenido de nuevo, usuario1@example.com!")

    # 🔹 Hacer clic en el botón "Cerrar sesión"
    click_button "Cerrar sesión"

    # Verificar que el usuario fue redirigido a la pantalla de login
    expect(page).to have_current_path(new_user_session_path, wait: 5)
    expect(page).to have_content("Iniciar Sesion")
  end
end
