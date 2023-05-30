# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

(1..10).each do |i|
  User.create!(
    email: "player#{i}@email.com",
    password: '123456',
    name: "player #{i}"
  )
end

User.create!(
  email: "admin@admin.com",
  password: '123456',
  name: "admin"
)

(1..10).each do |i|
  ms = MatchSeries.create!(
    name: "Series: #{i}"
  )
  (1..rand(1..10)).each do
    ms.match_series_participations.create!(
      user: User.take
    )
  end
end