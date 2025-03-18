require 'rails_helper'

RSpec.describe "Acceso restringido sin sesión iniciada", type: :system do
  before do
    driven_by(:selenium_chrome_headless)

    # Limpiar usuarios y sesiones
    User.destroy_all
    Capybara.reset_sessions!
  end

  it "redirecciona al usuario al login cuando intenta acceder a una página restringida" do
    # Intentar acceder a una página protegida sin haber iniciado sesión
    visit "/links/links" # Ruta restringida

    # Verificar que el usuario es redirigido al login
    expect(page).to have_current_path(new_user_session_path)
    expect(page).to have_content("Iniciar Sesion")
  end
end
