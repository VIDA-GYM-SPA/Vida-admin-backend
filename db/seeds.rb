# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Permission.create(name: "Ver dashboard", short_name: "R Dashboard")

Permission.create(name: "Crear usuarios", short_name: "C usuarios")
Permission.create(name: "Ver usuarios", short_name: "R Usuarios")
Permission.create(name: "Editar usuarios", short_name: "U usuarios")
Permission.create(name: "Eliminar usuarios", short_name: "D usuarios")

Permission.create(name: "Crear roles", short_name: "C roles")
Permission.create(name: "Ver roles", short_name: "R Roles")
Permission.create(name: "Editar roles", short_name: "U roles")
Permission.create(name: "Eliminar roles", short_name: "D roles")

Permission.create(name: "Crear permisos", short_name: "C permisos")
Permission.create(name: "Ver permisos", short_name: "R Permisos")
Permission.create(name: "Editar permisos", short_name: "U permisos")
Permission.create(name: "Eliminar permisos", short_name: "D permisos")

Permission.create(name: "Crear clientes", short_name: "C clientes")
Permission.create(name: "Ver clientes", short_name: "R Clientes")
Permission.create(name: "Editar clientes", short_name: "U clientes")
Permission.create(name: "Eliminar clientes", short_name: "D clientes")

Permission.create(name: "Crear metodos de pagos", short_name: "C Pago")
Permission.create(name: "Ver metodos de pagos", short_name: "R Pagos")
Permission.create(name: "Editar metodos de pagos", short_name: "U Pago")
Permission.create(name: "Eliminar metodos de pagos", short_name: "D Pago")

Permission.create(name: "Actualizar pagos de usuarios", short_name: " V")

Role.create(name: "admin", base_permissions: [
  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21
])
Role.create(name: "staff", base_permissions: [
  1, 14, 15, 16, 17
])
Role.create(name: "client")

User.create(name: 'Javier', lastname: 'Diaz', email: 'javierdiazt406@gmail.com', dni: "V-29543140", password: "12345678", password_confirmation: "12345678", gender: 'Male', role_id: 1, permissions: [1, 2])