require "ffaker"

UserRole.delete_all
OrderItem.delete_all
Order.delete_all
Product.delete_all
UserProfile.delete_all
User.delete_all
Role.delete_all

USERS_SIZE = 1_000
PRODUCTS_SIZE = 1_000
MIN_ORDERS_SIZE_PER_USER = 0
MAX_ORDERS_SIZE_PER_USER = 5
MIN_PRODUCTS_SIZE_PER_ORDER = 1
MAX_PRODUCTS_SIZE_PER_ORDER = 10
ROLES = %w[admin customer vendor]

puts "Seeding is starting..."

puts "Creating roles..."
ROLES.each do |role_name|
  Role.create!(role_name: role_name)
end
puts "Roles have created!"

puts "Creating products..."
PRODUCTS_SIZE.times do
  Product.create!(
    name: FFaker::Product.product_name,
    description: FFaker::Lorem.paragraph,
    price: FFaker::Number.decimal
  )
end
puts "Products have created!"

puts "Creating users..."
USERS_SIZE.times.with_index do |index|
  puts "User №#{index + 1}"

  user = User.create!(
    username: FFaker::InternetSE.unique.login_user_name,
    email: FFaker::Internet.unique.email,
    password_hash: FFaker::Internet.password
  )

  UserProfile.create!(
    user: user,
    first_name: FFaker::Name.first_name,
    last_name: FFaker::Name.last_name,
    address: FFaker::Address.street_address,
    phone_number: FFaker::PhoneNumber.phone_number
  )

  rand(MIN_ORDERS_SIZE_PER_USER..MAX_PRODUCTS_SIZE_PER_ORDER).times do
    order = Order.create!(
      user: user,
      total: FFaker::Number.decimal
    )

    rand(MIN_PRODUCTS_SIZE_PER_ORDER..MAX_PRODUCTS_SIZE_PER_ORDER).times do
      product = Product.order("RANDOM()").first
      OrderItem.create!(
        order: order,
        product: product,
        quantity: rand(1..10),
        price: product.price
      )
    end
  end
end
puts "Users have created!"

puts "Creating user roles..."
User.find_each do |user|
  roles = []
  rand(1..ROLES.length).times do
    role = Role.where.not(id: roles).order("RANDOM()").first
    roles.push(role.id)
    UserRole.create!(user: user, role: role)
  end
end
puts "User roles have created!"

puts "Seeding has completed!"
