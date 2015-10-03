# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_user(email)
  if User.where(email: email).exists?
    puts "User #{email} already exists."
  else
    puts "Creating user #{email}."
    User.create!(email: email, password: 'password')
  end
end

users = %w(admin@example.com regular@example.com)
users.each do |email|
  create_user(email)
end
