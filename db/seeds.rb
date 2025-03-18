# User.destroy_all
# Link.destroy_all
# Access.destroy_all

# # Crear algunos usuarios
# user1 = User.create(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
# user2 = User.create(email: 'usuario2@example.com', password: 'password456', username: 'usuario2')

# # Crear enlaces asociados a los usuarios
# # user1 con 4 links
# link1 = user1.links.build(name: 'Yout Tube', url: 'https://www.youtube.com/', link_type: 'regular')
# link1.generate_slug
# link1.save

# link2 = user1.links.build(name: 'Canva', url: 'https://www.canva.com/es_ar/', link_type: 'private', password: 'password')
# link2.generate_slug
# link2.save

# link3 = user1.links.build(name: 'UNLP', url: 'https://unlp.edu.ar', link_type: 'ephemeral', expiration_date: Time.now + 1.week)
# link3.generate_slug
# link3.save

# link4 = user1.links.build(name: 'GIT LAB CATEDRAS', url: 'https://gitlab.catedras.linti.unlp.edu.ar/users/sign_in', link_type: 'ephemeral', expiration_date: Time.now + 1.week)
# link4.generate_slug
# link4.save

# link5 = user1.links.build(name: 'Traductor', url: 'https://www.google.com/search?channel=fs&client=ubuntu-sn&q=traductor', link_type: 'regular')
# link5.generate_slug
# link5.save

# # Registrar accesos a través de los enlaces
# # 3 accesos para el link1
# link1.register_access('192.168.1.1')
# link1.register_access('192.168.1.2')
# link1.register_access('192.168.1.3')

# # 2 accesos para el link1
# link2.register_access('192.168.1.1')
# link2.register_access('192.168.1.2')

# puts 'Seeds creados exitosamente.'
################################################################################################################
if Rails.env.test?
    puts '⚠️ Eliminando datos anteriores...'
User.destroy_all
Link.destroy_all
Access.destroy_all

puts '🔹 Creando usuarios...'
user1 = User.create!(email: 'usuario1@example.com', password: 'password123', username: 'usuario1')
user2 = User.create!(email: 'usuario2@example.com', password: 'password456', username: 'usuario2')

puts '🔹 Creando enlaces para usuario1...'
user1.links.create!(
  name: 'YouTube',
  url: 'https://www.youtube.com/',
  link_type: 'regular',
  slug: SecureRandom.hex(2)
)

user1.links.create!(
  name: 'Canva',
  url: 'https://www.canva.com/es_ar/',
  link_type: 'private',
  password: 'password',
  slug: SecureRandom.hex(2)
)

user1.links.create!(
  name: 'UNLP',
  url: 'https://unlp.edu.ar',
  link_type: 'ephemeral',
  expiration_date: Time.now + 1.week,
  slug: SecureRandom.hex(2)
)

puts '✅ Seeds creados exitosamente.'

  end
  