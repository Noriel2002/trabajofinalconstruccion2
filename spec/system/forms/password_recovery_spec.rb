require 'rails_helper'

RSpec.describe "Recuperación de contraseña", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # Crear un usuario de prueba con username
    @user = User.create!(
      email: "usuario_prueba@example.com",
      username: "usuario_prueba",  # <-- Agrega un username válido
      password: "password123",
      password_confirmation: "password123"
    )

    # Limpiar sesiones previas
    Capybara.reset_sessions!
  end

  it "envía un correo de recuperación de contraseña" do
    # Visitar la página de recuperación de contraseña
    visit new_user_password_path

    # Verificar que la página cargó correctamente
    expect(page).to have_content("Olvidaste tu contraseña?")

    # Completar el campo de correo y enviar el formulario
    fill_in "user[email]", with: "usuario_prueba@example.com"
    click_button "Enviar email con instrucciones"

    # Verificar que se muestra el mensaje de éxito
    expect(page).to have_content("Recibirás un correo electrónico con instrucciones sobre cómo restablecer tu contraseña en unos minutos.")
  end
end
