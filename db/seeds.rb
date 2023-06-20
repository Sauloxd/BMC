# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'open-uri'

users = (1..10).map do |i|
  u = User.create!(
    email: "player#{i}@email.com",
    password: '123456',
    name: "player #{i}"
  )
  downloaded_image = URI.parse("https://ui-avatars.com/api/?background=random").open
  u.avatar.attach(io: downloaded_image  , filename: "random.jpg")
  u
end

User.create!(
  email: "admin@admin.com",
  password: '123456',
  name: "admin"
)

bmc = [
  ['Saulo Furuta', 'saulo@bmc.com'],
  ['Rebeca Chu', 'rebeca@bmc.com'],
  ['Ghe Kitamura', 'gheorgia@bmc.com'],
  ['Peter', 'peter@bmc.com'],
  ['Lucas Araujo', 'araujo@bmc.com'],
  ['Andre Skoll', 'andre@bmc.com'],
  ['João Tormin Vieira dos Santos', 'jt@bmc.com'],
  ['Filipe Tai', 'tipe@bmc.com'],
  ['Jacqueline Chen', 'jacque.chen@bmc.com'],
  ['William Tutihashi', 'will@bmc.com'],
  ['Paraiba', 'paraiba@bmc.com'],
].map do |u|
  User.create!(
    name: u.first,
    email: u.second,
    password: '123456',
  )
end

toxa = User.create!(
  email: 'toxa@bmc.com',
  password: '123456',
  name: 'Marcelo Kussano'
)

bmc << toxa

kosmos = Club.create!(name: 'Kosmos Club', owner: users.sample)
arena_on = Club.create!(name: 'Arena On', owner: users.sample)
kaizen = Club.create!(name: 'Arena Kaizen', owner: toxa)

bmc.each do |u|
  kaizen.memberships.create(user: u)
end

users.each do |u|
  arena_on.memberships.create(user: u)
  kosmos.memberships.create(user: u)
end

[arena_on, kosmos].each do |club|
  (1..10).each do |i|
    ms = club.match_series.create!(
      name: "Series: #{i}"
    )
    (1..rand(1..10)).each do
      ms.match_series_participations.create!(
        user: User.take
      )
    end
  end
end

ms = kaizen.match_series.create!(name: 'Ranking TTPS')
ms.match_series_participations.insert_all(
  User.where(email: ['toxa@bmc.com', 'saulo@bmc.com', 'peter@bmc.com', 'tipe@bmc.com']).pluck(:id).map {|id| { user_id: id } }
)

ms = kaizen.match_series.create!(name: 'Ranking BMC 2023')
ms.match_series_participations.insert_all(User.where(email: [
  'toxa@bmc.com', 'saulo@bmc.com', 'peter@bmc.com', 'tipe@bmc.com',
  'rebeca@bmc.com',
  'gheorgia@bmc.com',
  'araujo@bmc.com',
  'andre@bmc.com',
  'jt@bmc.com',
  'jacque.chen@bmc.com',
  'will@bmc.com',
  'paraiba@bmc.com',
]).pluck(:id).map {|id| { user_id: id } })
