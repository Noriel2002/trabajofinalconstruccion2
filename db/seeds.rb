User.destroy_all
Link.destroy_all
Access.destroy_all

# Crear algunos usuarios
user1 = User.create(email: 'usuario1@example.com', password: 'password123')
user2 = User.create(email: 'usuario2@example.com', password: 'password456')

# Crear enlaces asociados a los usuarios
# user1 con 3 links
link1 = user1.links.build(name: 'Enlace 1', url: 'https://example.com/link1', link_type: 'regular')
link1.generate_slug
link1.save

link2 = user1.links.build(name: 'Enlace 2', url: 'https://example.com/link2', link_type: 'private', password: 'password')
link2.generate_slug
link2.save

link3 = user1.links.build(name: 'Enlace 3', url: 'https://example.com/link3', link_type: 'ephemeral', expiration_date: Time.now + 1.week)
link3.generate_slug
link3.save

# Registrar accesos a través de los enlaces
# 3 accesos para el link1
link1.register_access('192.168.1.1')
link1.register_access('192.168.1.2')
link1.register_access('192.168.1.3')

# 2 accesos para el link1
link2.register_access('192.168.1.1')
link2.register_access('192.168.1.2')

puts 'Seeds creados exitosamente.'
