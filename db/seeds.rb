# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

[
  'user1@user.com',
  'user2@user.com',
  'user3@user.com',
  'user4@user.com',
  'user5@user.com',
].each do |email|
  User.create(
    {
      email: email,
      password: 'qwerty123'
    }
  )
end
