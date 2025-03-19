require 'rails_helper'

RSpec.describe "Pruebas de Integración", type: :request do
  let(:user) { User.create!(email: "usuario@example.com", username: "usuario123", password: "password123", password_confirmation: "password123") }

  it "Permite iniciar sesión con credenciales correctas" do
    post user_session_path, params: { user: { email: user.email, password: "password123" } }
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("¡Bienvenido de nuevo, usuario@example.com!")
  end

  it "No permite iniciar sesión con credenciales incorrectas" do
    post user_session_path, params: { user: { email: user.email, password: "wrongpassword" } }
    expect(response.body).to include("Usuario o contraseña incorrectos")
  end

  it "Permite registrar un nuevo usuario" do
    post user_registration_path, params: { user: { email: "nuevo@example.com", username: "nuevo_usuario", password: "password123", password_confirmation: "password123" } }
    expect(response).to redirect_to(root_path)
    follow_redirect!
    expect(response.body).to include("¡Bienvenido! Te has registrado exitosamente.")
  end

  it "No permite registrar un usuario con datos inválidos" do
    post user_registration_path, params: { user: { email: "", username: "", password: "", password_confirmation: "" } }
    expect(response.body).to include("no puede estar en blanco")
  end

  it "No permite recuperar la contraseña con un email no registrado" do
    post user_password_path, params: { user: { email: "inexistente@example.com" } }
    expect(response.body).to include("Email no fue encontrado")
  end

  it "Permite recuperar la contraseña con un email registrado" do
    post user_password_path, params: { user: { email: user.email } }
    follow_redirect!  
    expect(response.body).to include("Recibirás un correo electrónico con instrucciones sobre cómo restablecer tu contraseña")
  end

  it "Muestra el formulario de recuperación de contraseña" do
    get new_user_password_path
    expect(response).to have_http_status(:success)
    expect(response.body).to include("Olvidaste tu contraseña?")
  end

  it "Permite acceder a la página de links públicos sin iniciar sesión" do
    get "/public_links"  # Asegúrate de que esta ruta sea accesible sin autenticación
    expect(response).to have_http_status(:success)
    expect(response.body).to include("Ver Todos Links")  # Verifica que la página carga correctamente
  end

it "Permite ver la página de perfil después de iniciar sesión" do
    # Iniciar sesión primero
    post user_session_path, params: { user: { email: user.email, password: "password123" } }
    follow_redirect!
    expect(response.body).to include("¡Bienvenido de nuevo, usuario@example.com!")
  
    # Acceder a la página de perfil
    get "/show_profile"
    expect(response).to have_http_status(:success)
  
    # Verificar que se muestra el perfil del usuario
    expect(response.body).to include("Mi Perfil") # Basado en tu HTML
    expect(response.body).to include("usuario@example.com") # Verificar que aparece su email
  end  

  it "Permite navegar por la página de links autenticado" do
    post user_session_path, params: { user: { email: user.email, password: "password123" } }
    follow_redirect!

    get "/links/links"
    expect(response).to have_http_status(:success)
    expect(response.body).to include("Mis Links Cortos")  # Verificar que aparece la página de links
  end
end
