require 'rails_helper'

RSpec.describe "Registro de Usuario", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # Limpiar usuarios
    User.destroy_all

    # Restablecer sesión limpiando cookies
    Capybara.reset_sessions!

    # Intentar cerrar sesión si hay un usuario autenticado
    visit root_path
    if page.has_button?("Cerrar sesión")
      click_button "Cerrar sesión"
      sleep 1  # Esperar a que se cierre sesión completamente
    end
  end

  it "permite registrar un nuevo usuario y acceder con sus credenciales" do
    # Registro de usuario
    visit new_user_registration_path
    sleep 2  # Esperar a que la página cargue

    fill_in "user[email]", with: "nuevo_usuario@example.com"
    fill_in "user[username]", with: "nuevo_usuario"
    fill_in "user[password]", with: "password123"
    fill_in "user[password_confirmation]", with: "password123"

    click_button "Registrar"

    expect(page).to have_content("¡Bienvenido! Te has registrado exitosamente.")
  end
end
