# seeds.rb

# Crea un usuario de ejemplo
user = User.create(email: 'usuario@example.com', password: 'password')

# Crea un enlace temporal
Link.create(
  user: user,
  name: 'Enlace Temporal',
  url: 'https://example.com/temporal',
  link_type: 'temporary',
  expiration_date: Date.tomorrow # Este enlace expira mañana
)

# Crea un enlace privado con contraseña
Link.create(
  user: user,
  name: 'Enlace Privado',
  url: 'https://example.com/privado',
  link_type: 'private',
  password: 'secreto'
)

puts 'Seeds creados exitosamente.'