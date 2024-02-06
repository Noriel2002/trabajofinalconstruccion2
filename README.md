# README

# Aplicación de Generación y Gestión de Links Cortos

Esta es una aplicación web para generar y gestionar links cortos al estilo de servicios como Bitly, T.ly o TinyURL. El propósito es proporcionar links cortos para URLs largas, que pueden ser utilizados en redes sociales u otras plataformas online para compartir páginas web de manera sencilla.

## Requisitos Técnicos

- Ruby: Versión 2.7 o superior.
- Ruby on Rails: Versión 7.1.2 (la versión estable más reciente al momento de escribir este documento).
- Base de datos: SQLite.

## Dependencias

Para facilitar el desarrollo, se recomienda utilizar gemas establecidas que proporcionen funcionalidades comunes en aplicaciones web. Algunas sugerencias incluyen:

 - Gema Devise

    Devise es una gema de autenticación flexible para Rails que maneja el registro de usuarios, la sesión de inicio y cierre de sesión, la recuperación de contraseñas, la confirmación de cuentas y más. Esta gema es ampliamente utilizada y proporciona una solución robusta y segura para la autenticación de usuarios en aplicaciones Rails.
   
    Características principales:

    Registro de usuarios: Permite que los usuarios se registren en la aplicación proporcionando un correo electrónico y una contraseña.

    Inicio y cierre de sesión: Facilita la autenticación de usuarios al iniciar y cerrar sesión en la aplicación.

    Recuperación de contraseñas: Proporciona funcionalidad para que los usuarios recuperen sus contraseñas en caso de olvido.

    Confirmación de cuentas: Requiere que los usuarios confirmen sus correos electrónicos antes de activar sus cuentas.

    Envío de correo electrónico: Ofrece soporte para enviar correos electrónicos a los usuarios para diversas acciones, como confirmación de cuentas, recuperación de contraseñas, etc.
 
  - Simple Form: Una gema para la creación de formularios en Rails de manera más fácil y flexible. Permite definir formularios con menos código y ofrece una amplia variedad de opciones de configuración y personalización.

  - Bootstrap o Tailwind CSS: Utilizado para estilos en la interfaz de usuario. Bootstrap es un framework de diseño front-end popular que proporciona componentes predefinidos y estilos CSS, mientras que Tailwind CSS es una herramienta de utilidad de bajo nivel que permite construir diseños personalizados utilizando clases de CSS.

  - RSpec o MiniTest: Para pruebas unitarias y de integración. RSpec es un framework de pruebas BDD (Desarrollo Guiado por Comportamiento) que ofrece una sintaxis expresiva y legible, mientras que MiniTest es una biblioteca de pruebas incluida en Ruby que proporciona una forma simple de escribir pruebas unitarias y de integración

## Instalación

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/tu-proyecto.git
   cd tu-proyecto

2. Instalar las dependencias utilizando Bundler:
   bundle install

3. Configurar la base de datos y ejecutar las migraciones:
   rails db:create
   rails db:migrate

4. Iniciar el servidor de desarrollo:
   rails server

5. La aplicación estará disponible en http://localhost:3000.

## Uso

    Accede a la aplicación desde tu navegador web preferido.
    Visita a los links creados por los usuarios de la aplicacion.
    Regístrate o inicia sesión si ya tienes una cuenta.
    Genera un link corto ingresando la URL larga deseada.
    Podras visitar tu link.
    Podras ver el reporte de acceso y cantidad de veces por dia para tu link.

## Contribución

¡Las contribuciones son bienvenidas! Si deseas contribuir a este proyecto, por favor sigue estos pasos:

    Haz un fork del repositorio.
    Crea una nueva rama (git checkout -b feature/nueva-caracteristica).
    Realiza tus cambios y haz commits (git commit -am 'Agrega nueva característica').
    Haz push a la rama (git push origin feature/nueva-caracteristica).
    Abre un pull request.

