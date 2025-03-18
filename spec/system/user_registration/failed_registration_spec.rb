require 'rails_helper'

RSpec.describe "Registro de Usuario", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # Limpiar usuarios antes de cada prueba
    User.destroy_all

    # Crear un usuario existente
    @existing_user = User.create!(
      email: "usuario_existente@example.com",
      username: "usuario_existente",
      password: "password123",
      password_confirmation: "password123"
    )

    # Restablecer sesión limpiando cookies
    Capybara.reset_sessions!

    # Intentar cerrar sesión si hay un usuario autenticado
    visit root_path
    if page.has_button?("Cerrar sesión")
      click_button "Cerrar sesión"
      sleep 1  # Esperar a que se cierre sesión completamente
    end
  end

  it "muestra un error al intentar registrar un usuario con un email ya existente" do
    # Ir a la página de registro
    visit new_user_registration_path
    sleep 2  # Esperar a que la página cargue

    # Intentar registrarse con un email que ya existe
    fill_in "user[email]", with: "usuario_existente@example.com"
    fill_in "user[username]", with: "otro_usuario"
    fill_in "user[password]", with: "password123"
    fill_in "user[password_confirmation]", with: "password123"

    click_button "Registrar"

    # Verificar que aparece un mensaje de error
    expect(page).to have_content("Email ya ha sido tomado")
    end
end