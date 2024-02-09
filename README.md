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

## Desiciones de Diseño y Arquitectura

   # Links
    - Para la resolución de los distintos tipos de Link decidí optar por tener un único Modelo y un único Controlador, ya que al ser 4 tipos de Link y solo dos tipos de Link tenían un solo dato extra me parecio mejor tener un único modelo donde agrego esos dos campos con la condicion de que esten presentes cuando se quiere crear/editar el link con ese campo. 
    Para este enunciado en paritular me pareció bien hacerlo así, ya que no se menciona en un futuro agregar mas tipos de Link. En caso de agregarse a futuros mas tipos de links con mas campos, se deberia evaluar si seguir con un Unico modelo o resolverlo mediante STI.

      Para "crear/editar" tome la opcion de mostrar un único formulario para que el usurio ingrese todos los campos que requiera el tipo de link que quiere crear, aclarando en cada campo lo que debe rellenar para el tipo de Link que decida "crear/editar". Ej: si decide crear un link privado, además de la url(válida) y nombre(opcional) tendra que ingresar una contraseña, y en el campo de fecha de expiración para el link temporal no debe ingresar nada, en caso de ingresar no se guardará dicho valor en la base datos, ya que solo se guardará la contraseña; lo mismo pasa al crear un Link Temporal, se debe ingresar una fecha de expiracion(obligatoria), dejando el campo de contraseña vacía, en caso de ingresar una, no se guardará dicho valo. Para los Links Efimeros y Regulares solo se guardarán los datos: url(valida) y nombre(opcional). 
      Lo mismo pasa para "editar" un Link, se muestra un único formulario con los campos que completará el usuario dependiendo el Link a editar. Ej: en caso de cambiar de un Link Temporal a un Link Privado, en el formulario además, debera ingresar una contraseña, caso contrario se le advierte al usuario con un mensaje de alert que faltan campos por llenar y recarga la pantalla.

      Todo lo que acabo de nombrar es sin preguntar por el tipo de links en los metodos de mik controlador, ya que eso lo declare una sola vez en el modelo, con respecto a los campos que tienen que estar presente para el tipo de link actual que se quiera guardar(luego de editar)/crear.

      Hay un único metodo en el cual pregunto especificamente por el tipo de link, que es access_link, ya que dependiendo del tipo de link se debe hacer validaciones diferentes.

   # Usuarios
   - Para el manejo de los Usuarios (Inicio de Sesion/Cierre de Sesion/Registro/Recuperacion de Cuenta/Eliminacion de CUenta) decidí usar la Gema Devise, el cual mediante comandos se generan las Vistas/Modelos/Controladores. Lo que hice fue agregarle al controlador el metodo "configure_permitted_parameters" para poder agregar un campo mas a mi Usuario, en este caso un username. 

   # Dominio
   - Para el dominio decidi crear una variable en "config/locales/application.rb" : "DOMAIN = '127.0.0.1:3000'", el cual se ejecuta cuando creo la url corta de la siguiente manera: " self.url_short =  "#{MiProyectoRuby::Application::DOMAIN}/l/#{self.slug}" ", donde se pone el nombre del proyecto en primer lugar y luego el nombre del archivo donde esta declarado el dominio,y por ultimo el nombre de la variable. Asi es como todos los links que se crean tienen el dominio '127.0.0.1:3000'.

      En caso de que en un futuro se cambie el dominio solo se deberá acceder al archivo application.rb y cambiar el nombre del dominio que se requiera para la situación.

   # Reportes
   - Para los dos reportes que se pedian cree un Modelo Access con una relacion de depencidencia con la clase Link, con un unico campo de tipo stringllamado ip_address. En el controlador del link, cada vez que se accede exitosamente a un link (pasan las validaciones) se llama al metodo que se encuentra en el Modelo Link " register_access(ip_addres) " donde le paso la direccion IP del cliente que hizo la solicitud al servidor, de la siguiente forma: "link.register_access(request.remote_ip)", dentro del metodo de mi modelo Link donde hago  " register_access(ip_addres) " contiene una linea de codigo, donde hago un create de la clase access y le asingo a ip_address la direccion IP que recibe como parametro. 
   Una vez que guardo correctamente los accesos, para hacer el reporte para mostrar todas las direcciones IP que accedieron a un link simplemente desde el un metodo desde el controlador link llamo a un metodo del modelo Link, donde utilizo la clausula where con el ID del link que llamo al metodo.  
   Para ver la cantidad de acceso hago el mismo procedimiento de metodos, en el metodo del modelo Link utilizo la clausula where con el ID del link que llamo al metodo, y ademas agrupo el resultado mediante el campo de creacion de los links (created_at) y por ultimo cuento la cantidad del resultado final mediante la clausula count.

   Para el filtrado de IP, guardo el parametro en una variable de la IP que se quiere buscar, en un metodo del controlador link, luego uso la clausula where donde adentro de la misma utilizo la clausula LIKE, para que compare el fragmento de IP ingresado con todas las IP de acceso guardadas para el link actual, utilizo % adelante y otro %  atras en la variable, devolviendo las coincidencias totales o que contienen ese fragmento de IP ingresado.

   Para el filtrado por fechas tambien hago una consulta utilizando la clausula where, donde utilizo los dos parametros de fechas que ingreso el user y le agrego a cada parametro una funcion de Rails ( beginning_of_day y end_of_day ), asegurandome que me retorne los accesos entre las fechas ingresadas.   

   # Resolucion del link corto
   - Para la resolucion de los slug cree un metodo que contiene una unica linea, la cual al campo slug se le asigna un valor mediante una función random que genera 2 valores Hexadecimales (4 en total), me parecio una idea rapida y sencilla. Una cadena hexadecimal de longitud 4, como la que se genera con SecureRandom.hex(2), puede tener 16 potencia de 4 = 65,536 combinaciones posibles en total.
