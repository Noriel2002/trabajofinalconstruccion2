require 'rails_helper'

RSpec.describe "Acceso permitido con sesión iniciada", type: :system do
  before do
    driven_by(:selenium_chrome)

    # Crear un usuario de prueba
    @user = User.create!(
      email: "usuario_prueba@example.com",
      username: "usuario_prueba",
      password: "password123",
      password_confirmation: "password123"
    )

    # Limpiar sesiones previas
    Capybara.reset_sessions!
  end

  it "permite acceder a una página restringida después de iniciar sesión" do
    # Visitar la página de login
    visit new_user_session_path
    sleep 1  # Esperar a que la página cargue

    # Iniciar sesión con credenciales válidas
    fill_in "user[email]", with: "usuario_prueba@example.com"
    fill_in "user[password]", with: "password123"
    click_button "Iniciar Sesion"

    # Asegurar que el usuario inició sesión exitosamente
    expect(page).to have_content("¡Bienvenido de nuevo, usuario_prueba@example.com!")
  end
end
