require 'rails_helper'

RSpec.describe "Recordar sesión", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
    User.destroy_all
    @user = User.create!(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
  end

  it "mantiene la sesión iniciada tras cerrar y reabrir el navegador" do
    visit new_user_session_path

    fill_in "user_email", with: "usuario1@example.com"
    fill_in "user_password", with: "password123"
    check "user_remember_me"  # Asegúrate de que el nombre coincide con el del formulario

    click_button "Iniciar Sesion"

    expect(page).to have_content("¡Bienvenido de nuevo, usuario1@example.com!")

    # Simular cierre y reapertura del navegador eliminando solo las cookies (sin borrar la sesión en la BD)
    page.driver.browser.manage.delete_all_cookies
    visit root_path

    expect(page).to have_content("¡Bienvenido de nuevo, usuario1@example.com!") # La sesión debe persistir
  end
end
